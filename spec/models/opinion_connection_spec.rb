require 'rails_helper'

RSpec.describe OpinionConnection, type: :model do
  let!(:valid_opinion_connection) { create(:opinion_connection) }

  it "有効な｢接続線の始点があるHTML要素(反論)のid属性値｣と｢接続線の終点があるHTML要素(意見)のid属性値｣があれば有効な状態であること" do
    expect(valid_opinion_connection).to be_valid
  end

  it "接続線の始点があるHTML要素(反論)のid属性値､が無ければ無効な状態であること" do
    valid_opinion_connection.source_id = nil
    valid_opinion_connection.valid?
    expect(valid_opinion_connection.errors.full_messages.first).to eq "接続線の始点があるHTML要素(反論)のid属性値を入力してください"
  end

  it "接続線の終点があるHTML要素(意見)のid属性値､が無ければ無効な状態であること" do
    valid_opinion_connection.target_id = nil
    valid_opinion_connection.valid?
    expect(valid_opinion_connection.errors.full_messages.first).to eq "接続線の終点があるHTML要素(意見)のid属性値を入力してください"
  end
end
