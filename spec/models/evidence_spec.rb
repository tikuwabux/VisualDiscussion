require 'rails_helper'

RSpec.describe Evidence, type: :model do
  let(:annie) { create(:user, name: "annie") }
  let(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }
  let(:bad_for_health) { create(:conclusion, conclusion_summary: "健康に悪い", conclusion_detail: nil, agenda_board_id: about_early_bird.id, user_id: annie.id) }
  let(:misalignment_with_body_clock) { create(:reason, reason_summary: "人間の体内時計と噛み合っていないから", reason_detail: nil, conclusion_id: bad_for_health.id) }
  let!(:research_of_dr_kelly) { create(:evidence, reason_id: misalignment_with_body_clock.id, evidence_summary: "ケリー博士の研究") }

  it "有効な｢証拠｣,｢帰属先である理由のid値｣があれば有効な状態であること" do
    expect(research_of_dr_kelly).to be_valid
  end

  it "証拠が無ければ無効な状態であること" do
    research_of_dr_kelly.evidence_summary = nil
    research_of_dr_kelly.valid?
    expect(research_of_dr_kelly.errors.full_messages.first).to eq "証拠を入力してください"
  end

  it "帰属先である理由のid値が無ければ無効な状態であること" do
    research_of_dr_kelly.reason_id = nil
    research_of_dr_kelly.valid?
    expect(research_of_dr_kelly.errors.full_messages.first).to eq "帰属先である理由のid値を入力してください"
  end
end
