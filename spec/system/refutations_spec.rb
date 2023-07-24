require 'rails_helper'

RSpec.describe "Refutations", type: :system, js: true do
  let(:annie) { create(:user, name: "annie") }
  let(:brian) { create(:user, name: "brian") }

  let!(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }

  let(:bad_for_health) do
    create(:conclusion, agenda_board_id: about_early_bird.id, user_id: annie.id, conclusion_summary: "健康に悪い")
  end
  let(:misalignment_with_body_clock) { create(:reason, conclusion_id: bad_for_health.id, reason_summary: "人間の体内時計と噛み合っていないから") }
  let!(:lack_of_sleep) { create(:reason, conclusion_id: bad_for_health.id, reason_summary: "睡眠不足になりやすいから") }
  let!(:sleep_data) { create(:evidence, reason_id: misalignment_with_body_clock.id, evidence_summary: "世界中のあらゆる人々の睡眠データ") }
  let!(:research_of_dr_kelly) { create(:evidence, reason_id: misalignment_with_body_clock.id, evidence_summary: "ケリー博士の研究") }

  let(:good_for_health) do
    create(:conclusion, agenda_board_id: about_early_bird.id, user_id: brian.id, conclusion_summary: "健康に良い")
  end
  let(:the_early_bird_cateches_the_worm) do
    create(:reason, conclusion_id: good_for_health.id, reason_summary: "｢早起きは三文の得｣と昔から言うから")
  end
  let!(:fun_proverb_book) { create(:evidence, reason_id: the_early_bird_cateches_the_worm.id, evidence_summary: "楽しいことわざ本") }

  let(:problematic_reason) do
    create(:ref_conclusion, agenda_board_id: about_early_bird.id, user_id: brian.id, ref_conclusion_summary: "理由部分に誤りがある")
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

  let(:probalematic_conclusion_and_reason_connection) do
    create(:ref_conclusion, agenda_board_id: about_early_bird.id, user_id: annie.id, conclusion_id: good_for_health.id,
                            ref_conclusion_summary: "理由が結論に適するものではない")
  end
  let(:proverbs_are_didactic) do
    create(:ref_reason, ref_conclusion_id: probalematic_conclusion_and_reason_connection.id,
                        ref_reason_summary: "ことわざは例え話のようなもので事実性が低く､根拠として不適当だから")
  end
  let!(:make_haste_slowly) do
    create(:ref_evidence, ref_reason_id: proverbs_are_didactic.id,
                          ref_evidence_summary: "｢急がば回れ｣と言うが､待ち合わせに遅刻しそうなときは､googleマップを使って最短経路を進んだほうが良いと思う")
  end

  let(:problematic_reason_and_evidence_connection) do
    create(:ref_conclusion, agenda_board_id: about_early_bird.id, user_id: annie.id,
                            parent_ref_conclusion_id: problematic_reason.id, ref_conclusion_summary: "証拠が理由に適するものではない")
  end
  let(:not_survey_between_same_age_groups) do
    create(:ref_reason, ref_conclusion_id: problematic_reason_and_evidence_connection.id,
                        ref_reason_summary: "証拠にあげている調査は､同年齢を対象としたものではないから")
  end
  let!(:not_necessary) do
    create(:ref_evidence, ref_reason_id: not_survey_between_same_age_groups.id, ref_evidence_summary: "論理性の話であるため必要なし")
  end

  before do
    visit root_path
    click_on "ログイン"
    fill_in "メールアドレス", with: annie.email
    fill_in "パスワード", with: annie.password
    click_button "ログイン"
    click_on "#{annie.name}さんが作成した議題ボード"
    click_on about_early_bird.agenda

    # 主張･反論の要素を移動させ､重なりを防ぐことで､主張・反論下の各々のボタンが押せるようにする
    good_for_health_element = find("#argument#{good_for_health.id}")
    move_200px_to_the_right = "arguments[0].style.transform = 'translateX(200px)';"
    page.execute_script(move_200px_to_the_right, good_for_health_element)

    problematic_reason_element = find("#refutation#{problematic_reason.id}")
    move_400px_to_the_right = "arguments[0].style.transform = 'translateX(400px)';"
    page.execute_script(move_400px_to_the_right, problematic_reason_element)

    probalematic_conclusion_and_reason_connection_element = find("#refutation#{probalematic_conclusion_and_reason_connection.id}")
    move_600px_to_the_right = "arguments[0].style.transform = 'translateX(600px)';"
    page.execute_script(move_600px_to_the_right, probalematic_conclusion_and_reason_connection_element)

    problematic_reason_and_evidence_connection_element = find("#refutation#{problematic_reason_and_evidence_connection.id}")
    move_800px_to_the_right = "arguments[0].style.transform = 'translateX(800px)';"
    page.execute_script(move_800px_to_the_right, problematic_reason_and_evidence_connection_element)
  end

  context "主張下の｢新規反論作成｣ボタンをクリックして､新規反論作成ページにアクセスした時" do
    before do
      within "#argument#{bad_for_health.id}" do
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

  context "主張に対する反論下の｢反論を編集する｣ボタンをクリックして､反論編集ページにアクセスした時" do
    before do
      within "#refutation#{probalematic_conclusion_and_reason_connection.id}" do
        click_button "反論を編集する"
      end
    end

    scenario "反論対象の主張を動的に確認できること" do
      expect(page).to have_content good_for_health.conclusion_summary
      expect(page).to have_content good_for_health.conclusion_detail

      good_for_health.reasons.all? do |reason|
        expect(page).to have_content reason.reason_summary
        expect(page).to have_content reason.reason_summary

        reason.evidences.all? do |evidence|
          expect(page).to have_content evidence.evidence_summary
          expect(page).to have_content evidence.evidence_detail
        end
      end
    end

    describe "必要事項を入力して､｢反論を編集｣ボタンを押すと" do
      before do
        fill_in "結論", with: "理由が結論に繋がっていない"
        fill_in "結論詳細", with: "特になし"
        fill_in "理由", with: "ことわざに真実性はないから"
        fill_in "理由詳細", with: "特になし"
        fill_in "証拠", with: "｢犬が歩けば棒に当たる｣というが､必ずしも犬が歩くと､棒に当たるわけではない"
        fill_in "証拠詳細", with: "特になし"
        click_button "反論を編集する"
      end

      scenario "反論が編集されること" do
        expect(page).to have_content "反論の編集に成功しました"
      end

      scenario "反論が所属する議題ボード詳細ページに遷移すること" do
        expect(page).to have_current_path agenda_board_path(probalematic_conclusion_and_reason_connection.agenda_board_id)
      end
    end
  end

  context "反論下の｢新規反論作成｣ボタンをクリックして､新規反論作成ページにアクセスした時" do
    before do
      within "#refutation#{problematic_reason.id}" do
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

  context "反論に対する反論下の｢反論を編集する｣ボタンをクリックして､反論編集ページにアクセスした時" do
    before do
      within "#refutation#{problematic_reason_and_evidence_connection.id}" do
        click_button "反論を編集する"
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

    describe "必要事項を入力して､｢反論を編集｣ボタンを押すと" do
      before do
        fill_in "結論", with: "証拠が理由に繋がらない"
        fill_in "結論詳細", with: "特になし"
        fill_in "理由", with: "証拠にあげている調査は､同年齢を対象としたものではないから"
        fill_in "理由詳細", with: "特になし"
        fill_in "証拠", with: "論理性の話であるため必要なし"
        fill_in "証拠詳細", with: "特になし"
        click_button "反論を編集する"
      end

      scenario "反論が編集されること" do
        expect(page).to have_content "反論の編集に成功しました"
      end

      scenario "反論が所属する議題ボード詳細ページに遷移すること" do
        expect(page).to have_current_path agenda_board_path(problematic_reason_and_evidence_connection.agenda_board_id)
      end
    end
  end
end
