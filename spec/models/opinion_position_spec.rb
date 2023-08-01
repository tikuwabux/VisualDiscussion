require 'rails_helper'

RSpec.describe OpinionPosition, type: :model do
  let!(:valid_opinion_position) { create(:opinion_position) }

  it "有効な｢基準となる要素の左辺からの距離(px)｣と｢基準となる要素の上辺からの距離(px)｣があれば有効な状態であること" do
    expect(valid_opinion_position).to be_valid
  end

  it "基準となる要素の左辺からの距離(px)が無ければ無効な状態であること" do
    valid_opinion_position.left = nil
    valid_opinion_position.valid?
    expect(valid_opinion_position.errors.full_messages.first).to eq "基準となる要素の左辺からの距離(px)を入力してください"
  end

  it "基準となる要素の上辺からの距離(px)が無ければ無効な状態であること" do
    valid_opinion_position.top = nil
    valid_opinion_position.valid?
    expect(valid_opinion_position.errors.full_messages.first).to eq "基準となる要素の上辺からの距離(px)を入力してください"
  end
end
