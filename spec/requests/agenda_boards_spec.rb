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

RSpec.shared_examples("議題ボードの編集/削除に関するアクセス制限のテスト") do
  it "302リダイレクトを返すこと" do
    expect(response).to have_http_status(302)
  end

  it "ログインユーザーが作成した議題ボード一覧ページにリダイレクトされること" do
    expect(response).to redirect_to(current_user_created_agenda_boards_path)
  end

  it "設定したフラッシュメッセージがセットされていること" do
    expect(flash[:alert]).to eq("編集/削除する権限があるのは､あなた自身が作成した議題ボードのみです")
  end
end

RSpec.describe "AgendaBoards", type: :request do
  let(:annie) { create(:user, name: "annie") }
  let(:brian) { create(:user, name: "brian") }
  let!(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }

  context "未ログイン時" do
    describe "GET /agenda_boards/new" do
      before { get new_agenda_board_path }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end

    describe "POST /agenda_boards" do
      before { post agenda_boards_path }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end

    describe "GET /agenda_boards/:id" do
      before { get agenda_board_path(about_early_bird.id) }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end

    describe "GET /agenda_boards/index_created_by_current_user" do
      before { get current_user_created_agenda_boards_path }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end

    describe "GET /agenda_boards/index_with_opinion_posted_by_current_user" do
      before { get current_user_posted_opinion_agenda_boards_path }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end

    describe "GET /agenda_boards/index_searched_by_category" do
      before { get category_search_agenda_boards_path }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end

    describe "GET /agenda_boards/index_searched_by_agenda" do
      before { get agenda_search_agenda_boards_path }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end

    describe "GET /agenda_boards/:id/edit" do
      before { get edit_agenda_board_path(about_early_bird.id) }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end

    describe "PATCH /agenda_boards/:id" do
      before { patch agenda_board_path(about_early_bird.id) }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end

    describe "DELETE /agenda_boards/:id" do
      before { delete agenda_board_path(about_early_bird.id) }
      include_examples("未ログインユーザーに対するアクセス制限のテスト")
    end
  end

  context "既ログイン時" do
    before { sign_in(brian) }

    describe "以下の権限のない議題ボードの編集/削除に関するリクエストを行った時" do
      describe "GET /agenda_boards/:id/edit" do
        before { get edit_agenda_board_path(about_early_bird.id) }
        include_examples("議題ボードの編集/削除に関するアクセス制限のテスト")
      end

      describe "PATCH /agenda_boards/:id" do
        before { patch agenda_board_path(about_early_bird.id) }
        include_examples("議題ボードの編集/削除に関するアクセス制限のテスト")
      end

      describe "DELETE /agenda_boards/:id" do
        before { delete agenda_board_path(about_early_bird.id) }
        include_examples("議題ボードの編集/削除に関するアクセス制限のテスト")
      end
    end
  end
end
