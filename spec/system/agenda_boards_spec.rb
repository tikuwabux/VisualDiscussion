require 'rails_helper'

RSpec.describe "AgendaBoards", type: :system do
  let(:annie) { create(:user, name: "annie") }

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
end
