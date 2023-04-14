require 'rails_helper'

RSpec.describe "Arguments", type: :system do
  let(:annie) { create(:user, name: "annie") }
  let!(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }

  before do
    visit root_path
    click_on "ログイン"
    fill_in "メールアドレス", with: annie.email
    fill_in "パスワード", with: annie.password
    click_button "Log in"
  end

  describe "新規主張作成ページにアクセス後" do
    before do
      click_on "#{annie.name}さんが作成した議題ボード"
      click_on about_early_bird.agenda
      click_button "新規主張作成"
    end

    describe "必要事項を入力して､｢新規主張を作成する｣ボタンを押すと" do
      before do
        fill_in "結論", with: "健康に悪い"
        fill_in "結論詳細", with: "体と心の健康に悪い"
        fill_in "理由", with: "人間の体内時計と噛み合っていないから"
        fill_in "理由詳細", with: "青年期(15~30歳)の最適な起床時間は朝9時だから"
        fill_in "証拠", with: "ケリー博士の研究"
        fill_in "証拠詳細", with: "https://www.researchgate.net/profile/Paul-Kelley-4"
        click_button "新規主張を作成する"
      end

      scenario "新たな主張が作成されること" do
        expect(page).to have_content "新規主張の作成に成功しました"
      end

      scenario "主張が所属する議題ボード詳細ページに遷移すること" do
        expect(page).to have_current_path agenda_board_path(about_early_bird.id)
      end
    end
  end
end
