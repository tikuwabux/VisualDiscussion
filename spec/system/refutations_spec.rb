require 'rails_helper'

RSpec.describe "Refutations", type: :system do
  let(:annie) { create(:user, name: "annie") }
  let!(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }

  let(:bad_for_health) { create(:conclusion, agenda_board_id: about_early_bird.id, conclusion_summary: "健康に悪い") }
  let(:misalignment_with_body_clock) { create(:reason, conclusion_id: bad_for_health.id, reason_summary: "人間の体内時計と噛み合っていないから") }
  let!(:lack_of_sleep) { create(:reason, conclusion_id: bad_for_health.id, reason_summary: "睡眠不足になりやすいから") }
  let!(:sleep_data) { create(:evidence, reason_id: misalignment_with_body_clock.id, evidence_summary: "世界中のあらゆる人々の睡眠データ") }
  let!(:research_of_dr_kelly) { create(:evidence, reason_id: misalignment_with_body_clock.id, evidence_summary: "ケリー博士の研究") }

  let(:problematic_reason) { create(:ref_conclusion, agenda_board_id: about_early_bird.id, ref_conclusion_summary: "理由部分に誤りがある") }
  let(:individual_differences_in_body_clock) { create(:ref_reason, ref_conclusion_id: problematic_reason.id, ref_reason_summary: "体内時計は､同年齢間においても個人差があり､一律ではないから") }
  let!(:resetting_the_body_clock) { create(:ref_reason, ref_conclusion_id: problematic_reason.id, ref_reason_summary: "体内時計は､日の光を浴びることでリセットされるから") }
  let!(:results_of_sleep_time_survey) { create(:ref_evidence, ref_reason_id: individual_differences_in_body_clock.id, ref_evidence_summary: "8155名のMSFsc調査結果") }
  let!(:research_on_the_body_clock) { create(:ref_evidence, ref_reason_id: individual_differences_in_body_clock.id, ref_evidence_summary: "体内時計に関する研究") }

  before do
    visit root_path
    click_on "ログイン"
    fill_in "メールアドレス", with: annie.email
    fill_in "パスワード", with: annie.password
    click_button "Log in"
    click_on "#{annie.name}さんが作成した議題ボード"
    click_on about_early_bird.agenda
  end

  context "主張下の｢新規反論作成｣ボタンをクリックして､新規反論作成ページにアクセスした時" do
    before do
      within ".argument" do
        click_button "新規反論作成"
      end
    end

    scenario "反論対象の主張を動的に確認できること" do
      expect(page).to have_content bad_for_health.conclusion_summary
      expect(page).to have_content bad_for_health.conclusion_detail

      bad_for_health.reasons.all? do |reason|
        expect(page).to have_content reason.reason_summary
        expect(page).to have_content reason.reason_summary

        reason.evidences.all? do |evidence|
          expect(page).to have_content evidence.evidence_summary
          expect(page).to have_content evidence.evidence_detail
        end
      end
    end

    describe "必要事項を入力して､｢新規反論を作成する｣ボタンを押すと" do
      before do
        fill_in "結論", with: "理由部分に誤りがある"
        fill_in "結論詳細", with: "特になし"
        fill_in "理由", with: "体内時計は､同年齢間においても個人差があり､一律ではないから"
        fill_in "理由詳細", with: "特になし"
        fill_in "証拠", with: "8155名のMSFsc調査結果"
        fill_in "証拠詳細", with: "特になし"
        click_button "新規反論を作成する"
      end

      scenario "新たな反論が作成されること" do
        expect(page).to have_content "新規反論の作成に成功しました"
      end

      scenario "反論が所属する議題ボード詳細ページに遷移すること" do
        expect(page).to have_current_path agenda_board_path(about_early_bird.id)
      end
    end
  end

  context "反論下の｢新規反論作成｣ボタンをクリックして､新規反論作成ページにアクセスした時" do
    before do
      within ".refutation" do
        click_button "新規反論作成"
      end
    end

    scenario "反論対象の反論を動的に確認できること" do
      expect(page).to have_content problematic_reason.ref_conclusion_summary
      expect(page).to have_content problematic_reason.ref_conclusion_detail

      problematic_reason.ref_reasons.all? do |ref_reason|
        expect(page).to have_content ref_reason.ref_reason_summary
        expect(page).to have_content ref_reason.ref_reason_summary

        ref_reason.ref_evidences.all? do |ref_evidence|
          expect(page).to have_content ref_evidence.ref_evidence_summary
          expect(page).to have_content ref_evidence.ref_evidence_detail
        end
      end
    end

    describe "必要事項を入力して､｢新規反論を作成する｣ボタンを押すと" do
      before do
        fill_in "結論", with: "証拠と理由が繋がっていない"
        fill_in "結論詳細", with: "特になし"
        fill_in "理由", with: "証拠にあげている調査は､同年齢を対象としたものではないから"
        fill_in "理由詳細", with: "特になし"
        fill_in "証拠", with: "提示された調査は､様々な年齢の人々(平均年齢は36.7歳)を対象にしたものなので､
        ｢体内時計は同年齢間においても個人差がある｣という理由の証拠として適当ではない"
        fill_in "証拠詳細", with: "特になし"
        click_button "新規反論を作成する"
      end

      scenario "新たな反論が作成されること" do
        expect(page).to have_content "新規反論の作成に成功しました"
      end

      scenario "反論が所属する議題ボード詳細ページに遷移すること" do
        expect(page).to have_current_path agenda_board_path(about_early_bird.id)
      end
    end
  end
end
