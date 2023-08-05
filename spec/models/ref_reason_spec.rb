require 'rails_helper'

RSpec.describe RefReason, type: :model do
  let(:annie) { create(:user, name: "annie") }
  let(:brian) { create(:user, name: "brian") }
  let(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }
  let(:problematic_reason) do
    create(:ref_conclusion, ref_conclusion_summary: "理由部分に誤りがある", agenda_board_id: about_early_bird.id, user_id: brian.id)
  end
  let!(:individual_differences_in_body_clock) do
    create(:ref_reason, ref_reason_summary: "体内時計は､同年齢間においても個人差があり､一律ではないから", ref_conclusion_id: problematic_reason.id)
  end

  it "有効な｢理由｣,｢帰属先である結論のid値｣があれば有効な状態であること" do
    expect(individual_differences_in_body_clock).to be_valid
  end

  it "理由が無ければ無効な状態であること" do
    individual_differences_in_body_clock.ref_reason_summary = nil
    individual_differences_in_body_clock.valid?
    expect(individual_differences_in_body_clock.errors.full_messages.first).to eq "理由を入力してください"
  end

  it "帰属先である結論のid値が無ければ無効な状態であること" do
    individual_differences_in_body_clock.ref_conclusion_id = nil
    individual_differences_in_body_clock.valid?
    expect(individual_differences_in_body_clock.errors.full_messages.first).to eq "帰属先である結論のid値を入力してください"
  end
end
