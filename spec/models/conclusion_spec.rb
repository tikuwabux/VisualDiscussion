require 'rails_helper'

RSpec.describe Conclusion, type: :model do
  let(:annie) { create(:user, name: "annie") }
  let(:about_early_bird) { create(:agenda_board, user_id: annie.id, agenda: "早起きは健康によいのか?", category: "自然科学") }
  let!(:bad_for_health) do
    create(:conclusion, conclusion_summary: "健康に悪い", conclusion_detail: nil, agenda_board_id: about_early_bird.id,
                        user_id: annie.id)
  end

  it "有効な｢結論｣,｢所属する議題ボードのid値｣,｢作成したユーザーのid値｣があれば有効な状態であること" do
    expect(bad_for_health).to be_valid
  end

  it "結論が無ければ無効な状態であること" do
    bad_for_health.conclusion_summary = nil
    bad_for_health.valid?
    expect(bad_for_health.errors.full_messages.first).to eq "結論を入力してください"
  end

  it "所属する議題ボードのid値が無ければ無効な状態であること" do
    bad_for_health.agenda_board_id = nil
    bad_for_health.valid?
    expect(bad_for_health.errors.full_messages.first).to eq "所属する議題ボードのid値を入力してください"
  end

  it "作成者であるユーザーのid値が無ければ無効な状態であること" do
    bad_for_health.user_id = nil
    bad_for_health.valid?
    expect(bad_for_health.errors.full_messages.first).to eq "作成者であるユーザーのid値を入力してください"
  end
end
