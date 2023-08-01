require 'rails_helper'

RSpec.describe Reason, type: :model do
  let(:annie) { create(:user, name: "annie") }
  let(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }
  let(:bad_for_health) { create(:conclusion, conclusion_summary: "健康に悪い", conclusion_detail: nil, agenda_board_id: about_early_bird.id, user_id: annie.id) }
  let!(:misalignment_with_body_clock) { create(:reason, reason_summary: "人間の体内時計と噛み合っていないから", reason_detail: nil, conclusion_id: bad_for_health.id) }

  it "有効な｢理由｣,｢帰属先である結論のid値｣があれば有効な状態であること" do
    expect(misalignment_with_body_clock).to be_valid
  end

  it "理由が無ければ無効な状態であること" do
    misalignment_with_body_clock.reason_summary = nil
    misalignment_with_body_clock.valid?
    expect(misalignment_with_body_clock.errors.full_messages.first).to eq "理由を入力してください"
  end

  it "帰属先である結論のid値が無ければ無効な状態であること" do
    misalignment_with_body_clock.conclusion_id = nil
    misalignment_with_body_clock.valid?
    expect(misalignment_with_body_clock.errors.full_messages.first).to eq "帰属先である結論のid値を入力してください"
  end
end
