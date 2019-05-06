require 'rails_helper'

RSpec.describe User, type: :model do
  context "creation" do
    let(:some_text) { "some text" }

    it "must be invalid with empty data" do
      expect(User.create).to be_invalid
    end

    it "must be invalid with empty password" do
      expect(User.create.errors[:password]).to include(cant_be_blank)
    end

    it "must be invalid with empty email" do
      expect(User.create.errors[:email]).to include(cant_be_blank)
    end

    it "must have a valid email format" do
      user = User.create({ email: some_text })
      expect(user.errors[:email]).to include(is_not_email)
    end

    it "must be valid with an email and password" do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
    end

  end
end
