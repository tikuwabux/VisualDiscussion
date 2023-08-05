require 'rails_helper'

RSpec.describe RefConclusion, type: :model do
  let(:annie) { create(:user, name: "annie") }
  let(:brian) { create(:user, name: "brian") }
  let(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }
  let!(:problematic_reason) do
    create(:ref_conclusion, ref_conclusion_summary: "理由部分に誤りがある", agenda_board_id: about_early_bird.id, user_id: brian.id)
  end

  it "有効な｢結論｣,｢所属する議題ボードのid値｣,｢作成したユーザーのid値｣があれば有効な状態であること" do
    expect(problematic_reason).to be_valid
  end

  it "結論が無ければ無効な状態であること" do
    problematic_reason.ref_conclusion_summary = nil
    problematic_reason.valid?
    expect(problematic_reason.errors.full_messages.first).to eq "結論を入力してください"
  end

  it "所属する議題ボードのid値が無ければ無効な状態であること" do
    problematic_reason.agenda_board_id = nil
    problematic_reason.valid?
    expect(problematic_reason.errors.full_messages.first).to eq "所属する議題ボードのid値を入力してください"
  end

  it "作成者であるユーザーのid値が無ければ無効な状態であること" do
    problematic_reason.user_id = nil
    problematic_reason.valid?
    expect(problematic_reason.errors.full_messages.first).to eq "作成者であるユーザーのid値を入力してください"
  end
end
