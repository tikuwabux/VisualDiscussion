require 'rails_helper'

RSpec.describe "Home", type: :system do
  let(:annie) { create(:user, name: "annie") }

  describe "ホームページにアクセス後" do
    before do
      visit root_path
    end

    context "未ログイン時" do
      scenario "ヘッダー中にログインユーザーのメールアドレスを確認できないこと" do
        within "header" do
          expect(page).not_to have_content annie.email
        end
      end

      scenario "サインアップリンクを押すと､サインアップページに遷移すること" do
        click_on "サインアップ"
        expect(page).to have_current_path sign_up_path
      end

      scenario "ログインリンクを押すと､ログインページに遷移すること" do
        click_on "ログイン"
        expect(page).to have_current_path sign_in_path
      end
    end

    context "ログイン済みの時" do
      before do
        click_on "ログイン"
        fill_in "メールアドレス", with: annie.email
        fill_in "パスワード", with: annie.password
        click_button "Log in"
      end

      scenario "ヘッダー中にログインユーザーのメールアドレスを動的に確認できること" do
        within "header" do
          expect(page).to have_content annie.email
        end
      end

      scenario "プロフィール変更リンクを押すと､プロフィール変更ページに遷移すること" do
        click_on "プロフィール変更"
        expect(page).to have_current_path edit_user_registration_path
      end

      scenario "ログアウトリンクを押すと､未ログイン時のホームページに遷移すること" do
        click_on "ログアウト"
        expect(page).to have_current_path root_path
        within "header" do
          expect(page).not_to have_content annie.email
        end
      end

      scenario "｢新規議題ボード作成ページへ｣リンクを押すと､新規議題ボード作成ページに遷移すること" do
        click_on "新規議題ボード作成ページへ"
        expect(page).to have_current_path new_agenda_board_path
      end

      scenario "｢**(現在ログイン中のユーザー名)さんが作成した議題ボード｣リンクを押すと､議題ボード一覧ページに遷移すること" do
        click_on "#{annie.name}さんが作成した議題ボード"
        expect(page).to have_current_path agenda_boards_path
      end
    end
  end
end
