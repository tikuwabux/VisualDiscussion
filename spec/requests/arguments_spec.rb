require 'rails_helper'

RSpec.shared_examples("未ログインユーザーに対するアクセス制限のテスト") do
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

RSpec.shared_examples("主張の編集/削除に関するアクセス制限のテスト") do
  it "302リダイレクトを返すこと" do
    expect(response).to have_http_status(302)
  end

  it "設定したフラッシュメッセージがセットされていること" do
    expect(flash[:alert]).to eq("編集/削除する権限があるのは､あなた自身が作成した主張のみです")
  end
end

RSpec.describe "Arguments", type: :request do
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

  context "未ログイン時" do
    describe "GET /arguments/new" do
      before { get new_argument_path }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end

    describe "POST /arguments" do
      before { post arguments_path }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end

    describe "GET /arguments/:id/edit" do
      before { get edit_argument_path(very_bad_for_health.id) }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end

    describe "PATCH /arguments/:id" do
      before { patch argument_path(very_bad_for_health.id) }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end

    describe "DELETE /arguments/:id" do
      before { delete argument_path(very_bad_for_health.id) }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end
  end

  context "既ログイン時" do
    before { sign_in(brian) }

    describe "以下の権限のない主張の編集/削除に関するリクエストを行った時" do
      describe "GET /arguments/:id/edit" do
        before { get edit_argument_path(very_bad_for_health.id) }

        include_examples("主張の編集/削除に関するアクセス制限のテスト")
        it "編集しようとした主張が所属する議題ボード詳細ページへリダイレクトされること" do
          expect(response).to redirect_to(agenda_board_path(very_bad_for_health.agenda_board_id))
        end
      end

      describe "PATCH /arguments/:id" do
        before { patch argument_path(very_bad_for_health.id) }

        include_examples("主張の編集/削除に関するアクセス制限のテスト")
        it "編集しようとした主張が所属する議題ボード詳細ページへリダイレクトされること" do
          expect(response).to redirect_to(agenda_board_path(very_bad_for_health.agenda_board_id))
        end
      end

      describe "DELETE /arguments/:id" do
        before { delete argument_path(very_bad_for_health.id) }

        include_examples("主張の編集/削除に関するアクセス制限のテスト")
        it "削除しようとした主張が所属する議題ボード詳細ページへリダイレクトされること" do
          expect(response).to redirect_to(agenda_board_path(very_bad_for_health.agenda_board_id))
        end
      end
    end
  end
end
