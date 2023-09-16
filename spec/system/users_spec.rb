require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:annie) { create(:user, name: "annie") }
  let(:brian) { create(:user, name: "brian") }

  context "ログイン前の時" do
    before do
      visit root_path
    end

    describe "サインアップボタン押下後" do
      before do
        click_on "サインアップ"
      end

      describe "必須項目に有効な値を入力して､サインアップボタンを押すと" do
        before do
          fill_in "ニックネーム", with: "benny"
          fill_in "メールアドレス", with: "benny@example.com"
          fill_in "パスワード", with: 123456
          fill_in "確認用パスワード", with: 123456
          click_button "サインアップを完了する"
        end

        scenario "通知メッセージが表示されること" do
          expect(page).to have_content "アカウント登録が完了しました"
        end

        scenario "ログイン後のホームページに遷移すること" do
          expect(page).to have_current_path root_path
          within "header" do
            expect(page).to have_content "ログアウト"
          end
        end
      end

      scenario "ニックネームを入力せず､サインアップボタンを押すと､警告メッセージが表示されること" do
        fill_in "メールアドレス", with: "benny@example.com"
        fill_in "パスワード", with: 123456
        fill_in "確認用パスワード", with: 123456
        click_button "サインアップを完了する"
        expect(page).to have_content "ニックネームを入力してください"
      end

      scenario "重複するニックネームを入力して､サインアップボタンを押すと､警告メッセージが表示されること" do
        annie
        fill_in "ニックネーム", with: "annie"
        fill_in "メールアドレス", with: "benny@example.com"
        fill_in "パスワード", with: 123456
        fill_in "確認用パスワード", with: 123456
        click_button "サインアップを完了する"
        expect(page).to have_content "ニックネームはすでに存在します"
      end
    end

    describe "ログインリンク押下後" do
      before do
        click_on "ログイン"
      end

      describe "必須項目に有効な値を入力して､ログインボタンを押すと" do
        before do
          fill_in "メールアドレス", with: annie.email
          fill_in "パスワード", with: annie.password
          click_button "ログイン"
        end

        scenario "通知メッセージが表示されること" do
          expect(page).to have_content "ログインしました"
        end

        scenario "ログイン後のホームページに遷移すること" do
          expect(page).to have_current_path root_path
          within "header" do
            expect(page).to have_content "ログアウト"
          end
        end
      end
    end
  end

  context "ログイン後の時" do
    before do
      visit root_path
      click_on "ログイン"
      fill_in "メールアドレス", with: annie.email
      fill_in "パスワード", with: annie.password
      click_button "ログイン"
    end

    describe "ユーザー情報編集リンク押下後" do
      before do
        click_on "ユーザー情報編集"
      end

      describe "変更したい項目に有効な値を入力し､それに加えて現在のパスワードを入力して､｢編集を完了する｣ボタンを押すと" do
        before do
          fill_in "ニックネーム", with: "anniexxx"
          fill_in "現在のパスワード", with: annie.password
          click_button "編集を完了する"
        end

        scenario "通知メッセージが表示されること" do
          expect(page).to have_content "アカウント情報を変更しました。"
        end

        scenario "ログイン後のホームページに遷移すること" do
          expect(page).to have_current_path root_path
          within "header" do
            expect(page).to have_content "ログアウト"
          end
        end

        scenario "ユーザー情報が編集されていること" do
          expect(page).to have_link "anniexxxさんが作成した議題ボード"
        end
      end

      scenario "ニックネームを入力せず､｢編集を完了する｣ボタンを押すと､警告メッセージが表示されること" do
        fill_in "ニックネーム", with: nil
        fill_in "メールアドレス", with: annie.email
        fill_in "現在のパスワード", with: annie.password
        click_button "編集を完了する"
        expect(page).to have_content "ニックネームを入力してください"
      end

      scenario "重複するニックネームを入力して､｢編集を完了する｣ボタンを押すと､警告メッセージが表示されること" do
        brian
        fill_in "ニックネーム", with: "brian"
        fill_in "現在のパスワード", with: annie.password
        click_button "編集を完了する"
        expect(page).to have_content "ニックネームはすでに存在します"
      end
    end

    describe "ログアウトリンク押下後" do
      before do
        click_on "ログアウト"
      end

      scenario "通知メッセージが表示されること" do
        expect(page).to have_content "ログアウトしました。"
      end

      scenario "ログイン前のホームページに遷移すること" do
        expect(page).to have_current_path root_path
        within "header" do
          expect(page).to have_content "ログイン"
        end
      end
    end
  end
end
