require 'rails_helper'

RSpec.describe "AgendaBoards", type: :system do
  let(:annie) { create(:user, name: "annie") }
  let(:brian) { create(:user, name: "brian")}
  let(:catherine) { create(:user, name: "catherine") }

  let(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }
  let!(:about_chatbot) { create(:agenda_board, user_id: annie.id, agenda: "チャットボットは教育に悪影響を与えるのか?", category: "社会科学") }

  let(:bad_for_health) { create(:conclusion, agenda_board_id: about_early_bird.id, user_id: annie.id, conclusion_summary: "健康に悪い") }
  let!(:good_for_health) { create(:conclusion, agenda_board_id: about_early_bird.id, user_id: brian.id, conclusion_summary: "健康に良い") }
  let(:misalignment_with_body_clock) { create(:reason, conclusion_id: bad_for_health.id, reason_summary: "人間の体内時計と噛み合っていないから") }
  let!(:lack_of_sleep) { create(:reason, conclusion_id: bad_for_health.id, reason_summary: "睡眠不足になりやすいから") }
  let!(:sleep_data) { create(:evidence, reason_id: misalignment_with_body_clock.id, evidence_summary: "世界中のあらゆる人々の睡眠データ") }
  let!(:research_of_dr_kelly) { create(:evidence, reason_id: misalignment_with_body_clock.id, evidence_summary: "ケリー博士の研究") }

  let(:problematic_reason) { create(:ref_conclusion, agenda_board_id: about_early_bird.id, user_id: brian.id, ref_conclusion_summary: "理由部分に誤りがある") }
  let!(:problematic_reason_and_evidence_connection) do
    create(:ref_conclusion, agenda_board_id: about_early_bird.id, user_id: catherine.id, ref_conclusion_summary: "証拠が理由に適するものではない")
  end
  let(:individual_differences_in_body_clock) do
    create(:ref_reason, ref_conclusion_id: problematic_reason.id, ref_reason_summary: "体内時計は､同年齢間においても個人差があり､一律ではないから")
  end
  let!(:resetting_the_body_clock) do
    create(:ref_reason, ref_conclusion_id: problematic_reason.id, ref_reason_summary: "体内時計は､日の光を浴びることでリセットされるから")
  end
  let!(:results_of_sleep_time_survey) do
    create(:ref_evidence, ref_reason_id: individual_differences_in_body_clock.id, ref_evidence_summary: "8155名のMSFsc調査結果")
  end
  let!(:research_on_the_body_clock) do
    create(:ref_evidence, ref_reason_id: individual_differences_in_body_clock.id, ref_evidence_summary: "体内時計に関する研究")
  end

  before do
    visit root_path
    click_on "ログイン"
    fill_in "メールアドレス", with: annie.email
    fill_in "パスワード", with: annie.password
    click_button "Log in"
  end

  describe "新規議題ボード作成ページアクセス後" do
    before do
      click_on "新規議題ボード作成ページへ"
    end

    describe "議題を入力し､カテゴリを選択後､｢議題ボードを作成する｣ボタンを押すと" do
      before do
        fill_in "議題", with: "なぜ空は青いのか?"
        select "自然科学", from: "agenda_board_category"
        click_button "議題ボードを作成する"
      end

      scenario "新たな議題ボードが作成されること" do
        expect(page).to have_content "｢なぜ空は青いのか?｣のボード作成に成功しました"
      end

      scenario "作成した議題ボードの詳細ページに遷移すること" do
        expect(page).to have_current_path agenda_board_path(annie.agenda_boards.last.id)
      end
    end
  end

  describe "ログインユーザーが作成した議題ボード一覧ページにアクセス後" do
    before do
      click_on "#{annie.name}さんが作成した議題ボード"
    end

    scenario "議題ボードの議題名の一覧を動的に確認できる" do
      annie.agenda_boards.all? { |agenda_board| expect(page).to have_content agenda_board.agenda }
    end

    scenario "議題ボードのカテゴリ名の一覧を動的に確認できる" do
      annie.agenda_boards.all? { |agenda_board| expect(page).to have_content agenda_board.category }
    end

    scenario "議題名をクリックすると､その議題ボードの詳細ページに遷移すること" do
      click_on about_early_bird.agenda
      expect(page).to have_current_path agenda_board_path(about_early_bird.id)
    end
  end

  describe "議題ボード詳細ページアクセス後" do
    before do
      click_on "#{annie.name}さんが作成した議題ボード"
      click_on about_early_bird.agenda
    end

    scenario "｢新規主張作成｣ボタンをクリックすると､新規主張作成ページに遷移すること" do
      click_button "新規主張作成"
      expect(page).to have_current_path new_argument_path, ignore_query: true
    end

    scenario "すべての主張(結論+理由+証拠)を動的に確認できること" do
      about_early_bird.conclusions.all? do |conclusion|
        expect(page).to have_content conclusion.conclusion_summary
        expect(page).to have_content conclusion.conclusion_detail

        conclusion.reasons.all? do |reason|
          expect(page).to have_content reason.reason_summary
          expect(page).to have_content reason.reason_summary

          reason.evidences.all? do |evidence|
            expect(page).to have_content evidence.evidence_summary
            expect(page).to have_content evidence.evidence_detail
          end
        end
      end
    end

    scenario "｢新規反論作成｣ボタンをクリックすると､新規反論作成ページに遷移すること" do
      click_button "新規反論作成", match: :first
      expect(page).to have_current_path new_refutation_path, ignore_query: true
    end

    scenario "すべての反論(結論+理由+証拠)を動的に確認できること" do
      about_early_bird.ref_conclusions.all? do |ref_conclusion|
        expect(page).to have_content ref_conclusion.ref_conclusion_summary
        expect(page).to have_content ref_conclusion.ref_conclusion_detail

        ref_conclusion.ref_reasons.all? do |ref_reason|
          expect(page).to have_content ref_reason.ref_reason_summary
          expect(page).to have_content ref_reason.ref_reason_summary

          ref_reason.ref_evidences.all? do |ref_evidence|
            expect(page).to have_content ref_evidence.ref_evidence_summary
            expect(page).to have_content ref_evidence.ref_evidence_detail
          end
        end
      end
    end
  end
end
