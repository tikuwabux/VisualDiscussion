require 'rails_helper'

RSpec.describe AgendaBoard, type: :model do
  let(:annie) { create(:user, name: "annie") }
  let!(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }
  let!(:dummy_agenda_board) { create(:agenda_board, user_id: annie.id) }

  it "適切な｢議題｣､｢カテゴリ｣､｢作成者したuserのid値｣があれば有効な状態であること" do
    expect(about_early_bird).to be_valid
  end

  it "議題が無ければ無効な状態であること" do
    dummy_agenda_board.agenda = nil
    dummy_agenda_board.valid?
    expect(dummy_agenda_board.errors.full_messages.first).to eq "議題を入力してください"
  end

  it "重複した議題なら無効な状態であること" do
    dummy_agenda_board.agenda = "早起きは健康によいのか?"
    dummy_agenda_board.valid?
    expect(dummy_agenda_board.errors.full_messages.first).to eq "議題はすでに存在します"
  end
end
