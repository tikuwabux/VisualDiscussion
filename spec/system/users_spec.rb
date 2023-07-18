require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:annie) { create(:user, name: "annie") }

  context "ログイン前の時" do
    before do
      visit root_path
    end

    describe "サインアップボタン押下後" do
      before do
        click_on "サインアップ"
      end

      scenario "必須項目を入力して､サインアップボタンを押すと､ログイン後のホームページに遷移すること" do
        fill_in "Name", with: "benny"
        fill_in "メールアドレス", with: "benny@example.com"
        fill_in "パスワード", with: 123456
        fill_in "確認用パスワード", with: 123456
        click_button "Sign up"
        expect(page).to have_current_path root_path
        within "header" do
          expect(page).to have_content "ログアウト"
        end
      end

      scenario "Log inリンクを押すと､ログインページに遷移すること" do
        click_on "Log in"
        expect(page).to have_current_path new_user_session_path
      end
    end

    describe "ログインリンク押下後" do
      before do
        click_on "ログイン"
      end

      scenario "必須項目を入力して､ログインボタンを押すと､ログイン後のホームページに遷移すること" do
        fill_in "メールアドレス", with: annie.email
        fill_in "パスワード", with: annie.password
        click_button "Log in"
      end

      scenario "Sign upリンクを押すと､サインアップページに遷移すること" do
        click_on "Sign up"
        expect(page).to have_current_path new_user_registration_path
      end

      scenario "Forgot your password?リンクを押すと､パスワード再設定ページに遷移すること" do
        click_on "Forgot your password"
        expect(page).to have_current_path new_user_password_path
      end
    end
  end

  context "ログイン後の時" do
    before do
      visit root_path
      click_on "ログイン"
      fill_in "メールアドレス", with: annie.email
      fill_in "パスワード", with: annie.password
      click_button "Log in"
    end

    describe "プロフ変更リンク押下後" do
      before do
        click_on "プロフ変更"
      end

      describe "変更したい項目と現在のパスワードを入力して､updateボタンを押すと" do
        before do
          fill_in "メールアドレス", with: "annie@example.com"
          fill_in "現在のパスワード", with: annie.password
          click_button "Update"
        end

        scenario "アカウント情報が変更されること" do
          expect(page).to have_content "アカウント情報を変更しました。"
        end

        scenario "ログイン後のホームページに遷移すること" do
          expect(page).to have_current_path root_path
          within "header" do
            expect(page).to have_content "ログアウト"
          end
        end
      end

      describe "Cancel my accountボタンを押すと" do
        before do
          click_button "Cancel my account"
        end

        scenario "アカウントが消去されること" do
          expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
        end

        scenario "ログイン後のホームページに遷移すること" do
          expect(page).to have_current_path root_path
          within "header" do
            expect(page).not_to have_content annie.email
          end
        end
      end

      scenario "Backリンクを押すと､ログイン後のホームページに遷移すること" do
        click_on "Back"
        expect(page).to have_current_path root_path
        within "header" do
          expect(page).to have_content "ログアウト"
        end
      end
    end

    describe "ログアウトリンク押下後" do
      before do
        click_on "ログアウト"
      end

      scenario "ログアウトが実行されること" do
        expect(page).to have_content "ログアウトしました。"
      end

      scenario "ログイン前のホームページに遷移すること" do
        expect(page).to have_current_path root_path
        within "header" do
          expect(page).not_to have_content "ログアウト"
        end
      end
    end
  end
end
