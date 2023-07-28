require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:annie) { create(:user, name: "annie") }

  it "適切な｢ニックネーム｣,｢メールアドレス｣,｢パスワード｣があれば有効な状態であること" do
    expect(user).to be_valid
  end

  it "ニックネームが無ければ無効な状態であること" do
    user.name = nil
    user.valid?
    expect(user.errors.full_messages.first).to eq "ニックネームを入力してください"
  end

  it "重複したニックネームなら無効な状態であること" do
    user.name = "annie"
    user.valid?
    expect(user.errors.full_messages.first).to eq "ニックネームはすでに存在します"
  end

  describe '.guest' do
    context "ゲストユーザーがすでに存在する時" do
      let!(:guest_user) { create(:user, name: 'guest', email: 'guest@example.com', password: SecureRandom.urlsafe_base64) }

      it '既存のゲストユーザーを返すこと' do
        result_user = User.guest
        expect(result_user).to eq guest_user
      end
    end

    context "ゲストユーザーがまだ存在しない時" do
      before do
        User.find_by(email: 'guest@example.com')&.destroy
        expect(User.where(email: 'guest@example.com')).to be_empty
      end

      it '新たなゲストユーザーを作成し､そのユーザーを返すこと' do
        result_user = User.guest
        expect(result_user).to be_persisted
        expect(result_user.name).to eq 'guest'
        expect(result_user.email).to eq 'guest@example.com'
      end
    end
  end
end
