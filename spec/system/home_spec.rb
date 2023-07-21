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

      scenario "｢ゲストログイン｣リンクを押すと､ゲストログイン後､ホームページに遷移すること" do
        click_on "ゲストログイン"
        expect(page).to have_content 'ゲストユーザーとしてログインしました｡'
        expect(page).to have_current_path root_path
      end

      scenario "｢新規登録して議題ボードを作成する｣リンクを押すと､サインアップページに遷移すること" do
        click_on '新規登録して議題ボードを作成する'
        expect(page).to have_current_path sign_up_path
      end

      scenario "｢ログインする｣リンクを押すと､ログインページに遷移すること" do
        click_on 'ログインする'
        expect(page).to have_current_path sign_in_path
      end

      scenario "｢ゲストログインする｣リンクを押すと､ゲストログイン後､ホームページに遷移すること" do
        click_on 'ゲストログインする'
        expect(page).to have_content 'ゲストユーザーとしてログインしました｡'
        expect(page).to have_current_path root_path
      end
    end

    context "ログイン済みの時" do
      before do
        click_on "ログイン"
        fill_in "メールアドレス", with: annie.email
        fill_in "パスワード", with: annie.password
        click_button "Log in"
      end

      scenario "プロフ変更リンクを押すと､プロフ変更ページに遷移すること" do
        click_on "プロフ変更"
        expect(page).to have_current_path edit_user_registration_path
      end

      scenario "ログアウトリンクを押すと､未ログイン時のホームページに遷移すること" do
        click_on "ログアウト"
        expect(page).to have_current_path root_path
        within "header" do
          expect(page).not_to have_content annie.email
        end
      end

      scenario "｢新規議題ボード作成｣リンクを押すと､新規議題ボード作成ページに遷移すること" do
        click_on "新規議題ボード作成"
        expect(page).to have_current_path new_agenda_board_path
      end

      scenario "｢**(ログインユーザー)さんが作成した議題ボード一覧｣リンクを押すと､ログインユーザーが作成した議題ボード一覧ページに遷移すること" do
        click_on "#{annie.name}さんが作成した議題ボード"
        expect(page).to have_current_path current_user_created_agenda_boards_path
      end

      scenario "｢**(ログインユーザー)さんが発言した議題ボード｣リンクを押すと､｢**(ログインユーザー)さんが発言した議題ボード一覧｣ページに繊維すること" do
        click_on "#{annie.name}さんが発言した議題ボード"
        expect(page).to have_current_path current_user_posted_opinion_agenda_boards_path
      end

      scenario "ヘッダー中の｢議題ボード検索フォーム(カテゴリ選択式)｣でカテゴリを選択して､検索ボタンを押すと､選択したカテゴリを有する議題ボード一覧ページに遷移すること" do
        within "header" do
          select "自然科学", from: 'agenda_board_search_category'
          click_on 'カテゴリ名で検索'
        end
        expect(page).to have_current_path category_search_agenda_boards_path, ignore_query: true
        expect(page).to have_content '｢自然科学｣のカテゴリをもつ議題ボード一覧'
      end

      scenario "ヘッダー中の｢議題ボード検索フォーム(議題名入力式)｣で議題名を入力して､検索ボタンを押すと､入力した議題名を含む議題ボード一覧ページに遷移すること" do
        within "header" do
          fill_in '議題名(複数単語可)', with: '起き 健康'
          click_on '議題名で検索'
        end
        expect(page).to have_current_path agenda_search_agenda_boards_path, ignore_query: true
        expect(page).to have_content '｢起き 健康｣を議題名に含む議題ボード一覧'
      end

      scenario "｢新たな議題ボードを作成する｣リンクを押すと､新規議題ボード作成ページに遷移すること" do
        click_on "新たな議題ボードを作成する"
        expect(page).to have_current_path new_agenda_board_path
      end

      scenario "ヘッダー中の｢議題ボード検索フォーム(カテゴリ選択式)｣でカテゴリを選択して､検索ボタンを押すと､選択したカテゴリを有する議題ボード一覧ページに遷移すること" do
        within "header" do
          select "自然科学", from: 'agenda_board_search_category'
          click_on 'カテゴリ名で検索'
        end
        expect(page).to have_current_path category_search_agenda_boards_path, ignore_query: true
        expect(page).to have_content '｢自然科学｣のカテゴリをもつ議題ボード一覧'
      end

      scenario "メイン中の｢議題ボード検索フォーム(カテゴリ選択式)｣でカテゴリを選択して､検索ボタンを押すと､選択したカテゴリを有する議題ボード一覧ページに遷移すること" do
        within ".search_area" do
          select "自然科学", from: 'agenda_board_search_category'
          click_on 'カテゴリ名で検索'
        end
        expect(page).to have_current_path category_search_agenda_boards_path, ignore_query: true
        expect(page).to have_content '｢自然科学｣のカテゴリをもつ議題ボード一覧'
      end

      scenario "メイン中の｢議題ボード検索フォーム(議題名入力式)｣で議題名を入力して､検索ボタンを押すと､入力した議題名を含む議題ボード一覧ページに遷移すること" do
        within ".search_area" do
          fill_in '議題名(複数単語可)', with: '起き 健康'
          click_on '議題名で検索'
        end
        expect(page).to have_current_path agenda_search_agenda_boards_path, ignore_query: true
        expect(page).to have_content '｢起き 健康｣を議題名に含む議題ボード一覧'
      end
    end
  end
end
