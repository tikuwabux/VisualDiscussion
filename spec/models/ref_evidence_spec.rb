require 'rails_helper'

RSpec.describe RefEvidence, type: :model do
  let(:annie) { create(:user, name: "annie") }
  let(:brian) { create(:user, name: "brian") }
  let(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }
  let(:problematic_reason) do
    create(:ref_conclusion, ref_conclusion_summary: "理由部分に誤りがある", agenda_board_id: about_early_bird.id, user_id: brian.id)
  end
  let(:individual_differences_in_body_clock) do
    create(:ref_reason, ref_reason_summary: "体内時計は､同年齢間においても個人差があり､一律ではないから", ref_conclusion_id: problematic_reason.id)
  end
  let!(:results_of_sleep_time_survey) do
    create(:ref_evidence, ref_reason_id: individual_differences_in_body_clock.id, ref_evidence_summary: "8155名のMSFsc調査結果")
  end

  it "有効な｢証拠｣,｢帰属先である理由のid値｣があれば有効な状態であること" do
    expect(results_of_sleep_time_survey).to be_valid
  end

  it "証拠が無ければ無効な状態であること" do
    results_of_sleep_time_survey.ref_evidence_summary = nil
    results_of_sleep_time_survey.valid?
    expect(results_of_sleep_time_survey.errors.full_messages.first).to eq "証拠を入力してください"
  end

  it "帰属先である理由のid値が無ければ無効な状態であること" do
    results_of_sleep_time_survey.ref_reason_id = nil
    results_of_sleep_time_survey.valid?
    expect(results_of_sleep_time_survey.errors.full_messages.first).to eq "帰属先である理由のid値を入力してください"
  end
end
