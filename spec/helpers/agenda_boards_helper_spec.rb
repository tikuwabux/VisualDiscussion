require 'rails_helper'

RSpec.describe AgendaBoardsHelper, type: :helper do
  let(:annie) { create(:user, name: "annie") }
  let(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }
  let!(:good_for_health) do
    create(:conclusion, agenda_board_id: about_early_bird.id, user_id: annie.id, conclusion_summary: "健康に良い")
  end

  describe "#speaker_name(opinion)" do
    it "引数に意見(主張or反論)が渡されたとき､その発言者の名前を返すこと" do
      expect(speaker_name(good_for_health)).to eq "annie"
    end
  end
end
