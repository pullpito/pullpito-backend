require 'rails_helper'

RSpec.describe User, type: :model do
  context "creation" do

    it "must be invalid with empty data" do
      expect(User.create).to be_invalid
    end

    it "must be invalid with empty password" do
      expect(User.create.errors[:password]).to include("can't be blank")
    end

    it "must be invalid with empty email" do
      expect(User.create.errors[:email]).to include("can't be blank")
    end

    it "must have a valid email format" do
      user = User.create({ email: "lorem" })
      expect(user.errors[:email]).to include("is not an email")
    end

    it "must be valid with an email and password" do
      user = User.create({ email: "test@email.com", password: "password" })
      expect(user).to be_valid
    end

  end
end
