require 'rails_helper'

RSpec.shared_examples("未ログイン時ユーザーに対するアクセス制限のテスト") do
  it "302リダイレクトを返すこと" do
    expect(response).to have_http_status(302)
  end

  it "ログインページにリダイレクトされること" do
    expect(response).to redirect_to(sign_in_path)
  end

  it "設定したフラッシュメッセージがセットされていること" do
    expect(flash[:alert]).to eq("ログインもしくはサインアップが必要です")
  end
end

RSpec.shared_examples("反論の編集/削除に関するアクセス制限のテスト") do
  it "302リダイレクトを返すこと" do
    expect(response).to have_http_status(302)
  end

  it "設定したフラッシュメッセージがセットされていること" do
    expect(flash[:alert]).to eq("編集/削除する権限があるのは､あなた自身が作成した反論のみです")
  end
end

RSpec.describe "Refutations", type: :request do
  let(:annie) { create(:user, name: "annie") }
  let(:brian) { create(:user, name: "brian") }

  let(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }

  let(:very_bad_for_health) do
    create(:conclusion, agenda_board_id: about_early_bird.id, user_id: annie.id, conclusion_summary: "かなり健康に悪く拷問に等しい")
  end
  let(:increased_risk_of_various_diseases) do
    create(:reason, conclusion_id: very_bad_for_health.id, reason_summary: "早起きは様々な病気のリスクを上げることが明らかになっているから")
  end
  let!(:research_data) do
    create(:evidence, reason_id: increased_risk_of_various_diseases.id, evidence_summary: "早起きが､糖尿病､高血圧などの病気のリスクを上げていることを示す研究データ")
  end

  let(:problematic_reason) do
    create(:ref_conclusion, agenda_board_id: about_early_bird.id, user_id: brian.id, ref_conclusion_summary: "理由部分に誤りがある")
  end
  let(:individual_differences_in_body_clock) do
    create(:ref_reason, ref_conclusion_id: problematic_reason.id, ref_reason_summary: "体内時計は､同年齢間においても個人差があり､一律ではないから")
  end
  let!(:results_of_sleep_time_survey) do
    create(:ref_evidence, ref_reason_id: individual_differences_in_body_clock.id, ref_evidence_summary: "8155名のMSFsc調査結果")
  end

  context "未ログイン時" do
    describe "GET /refutations/new" do
      before { get new_refutation_path }
      include_examples("未ログイン時ユーザーに対するアクセス制限のテスト")
    end

    describe "POST /refutations" do
      before { post refutations_path }
      include_examples("未ログイン時ユーザーに対するアクセス制限のテスト")
    end

    describe "GET /refutations/:id/edit" do
      before { get edit_refutation_path(problematic_reason.id) }
      include_examples("未ログイン時ユーザーに対するアクセス制限のテスト")
    end

    describe "PATCH /refutations/:id" do
      before { patch refutation_path(problematic_reason.id) }
      include_examples("未ログイン時ユーザーに対するアクセス制限のテスト")
    end

    describe "DELETE /refutations/:id" do
      before { delete refutation_path(problematic_reason.id) }
      include_examples("未ログイン時ユーザーに対するアクセス制限のテスト")
    end
  end

  context "既ログイン時" do
    before { sign_in(annie) }

    describe "以下の権限のない反論の編集/削除に関するリクエストを行った時" do
      describe "GET /refutations/:id/edit" do
        before { get edit_refutation_path(problematic_reason.id) }

        include_examples("反論の編集/削除に関するアクセス制限のテスト")
        it "編集しようとした反論が所属する議題ボード詳細ページへリダイレクトされること" do
          expect(response).to redirect_to(agenda_board_path(problematic_reason.agenda_board_id))
        end
      end

      describe "PATCH /refutations/:id" do
        before { patch refutation_path(problematic_reason.id) }

        include_examples("反論の編集/削除に関するアクセス制限のテスト")
        it "編集しようとした反論が所属する議題ボード詳細ページへリダイレクトされること" do
          expect(response).to redirect_to(agenda_board_path(problematic_reason.agenda_board_id))
        end
      end

      describe "DELETE /refutations/:id" do
        before { delete refutation_path(problematic_reason.id) }

        include_examples("反論の編集/削除に関するアクセス制限のテスト")
        it "削除しようとした反論が所属する議題ボード詳細ページへリダイレクトされること" do
          expect(response).to redirect_to(agenda_board_path(problematic_reason.agenda_board_id))
        end
      end
    end
  end
end
