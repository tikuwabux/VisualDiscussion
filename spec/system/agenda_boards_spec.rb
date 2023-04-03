require 'rails_helper'

RSpec.describe "AgendaBoards", type: :system do
  let(:annie) { create(:user, name: "annie") }
  let!(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }
  let!(:about_chatbot) { create(:agenda_board, user_id: annie.id, agenda: "チャットボットは教育に悪影響を与えるのか?", category: "社会科学") }

  describe "新規議題ボード作成ページアクセス後" do
    before do
      visit root_path
      click_on "ログイン"
      fill_in "メールアドレス", with: annie.email
      fill_in "パスワード", with: annie.password
      click_button "Log in"
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
      visit root_path
      click_on "ログイン"
      fill_in "メールアドレス", with: annie.email
      fill_in "パスワード", with: annie.password
      click_button "Log in"
      click_on "#{annie.name}さんが作成した議題ボード"
    end

    scenario "議題ボードの議題名の一覧を動的に確認できる" do
      save_and_open_page
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
end
