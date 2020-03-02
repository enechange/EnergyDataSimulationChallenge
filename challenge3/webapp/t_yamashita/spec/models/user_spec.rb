require 'rails_helper'

describe User do
  describe '#create' do
    it "名前が入力されていないと登録できない" do
      user = build(:user, firstname: "")
      user.valid?
      expect(user.errors[:firstname]).to include("を入力してください")
    end

    it "苗字が入力されていないと登録できない" do
      user = build(:user, lastname: "")
      user.valid?
      expect(user.errors[:lastname]).to include("を入力してください")
    end


    it "メールアドレスが入力されていなければ登録できない" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "パスワードが入力されていなければ登録できない" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("は英数字の両方が必要です")
    end

    it "パスワード確認が入力されていなければ登録できない" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("を入力してください")
    end

    it "メールアドレスが重複すると登録できない" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "メールアドレスの@の前に文字が無いと登録できない" do
      user = build(:user, email: "@example.com")
      user.valid?
      expect(user.errors[:email]).to include("が不正です")
    end

    it "メールアドレスの@の後に文字が無いと登録できない" do
      user = build(:user, email: "a@")
      user.valid?
      expect(user.errors[:email]).to include("が不正です")
    end

    it "メールアドレスの@が無いと登録できない" do
      user = build(:user, email: "aexample.com")
      user.valid?
      expect(user.errors[:email]).to include("が不正です")
    end

    it "メールアドレスの@の後に.が無いと登録できない" do
      user = build(:user, email: "a@examplecom")
      user.valid?
      expect(user.errors[:email]).to include("が不正です")
    end

    it "パスワードが6文字以上であれば登録できる" do
      user = build(:user, password: "111aaa", password_confirmation: "111aaa")
      expect(user).to be_valid
    end

    it "パスワードが5文字以下では登録できない" do
      user = build(:user, password: "111aa", password_confirmation: "111aa")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "パスワードが数字のみでは登録できない" do
      user = build(:user, password: "111111")
      user.valid?
      expect(user.errors[:password]).to include("は英数字の両方が必要です")
    end

    it "パスワードが英語のみでは登録できない" do
      user = build(:user, password: "aaaaaa")
      user.valid?
      expect(user.errors[:password]).to include("は英数字の両方が必要です")
    end

    it "パスワード(確認)が数字のみでは登録できない" do
      user = build(:user, password_confirmation: "111111")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("は英数字の両方が必要です")
    end

    it "パスワード(確認)が英語のみでは登録できない" do
      user = build(:user, password_confirmation: "aaaaaa")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("は英数字の両方が必要です")
    end

    it "パスワードとパスワード(確認)が一致しない場合登録できない" do
      user = build(:user, password_confirmation: "1b1b1b1b")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "名前、苗字、メールアドレス、パスワード、確認、居住地が適切であれば登録できる" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end
