require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:empty_profile) { Profile.create }
  let(:not_strip_values_profile) { Profile.create({ first_name: " ", last_name: " " }) }
  let(:valid_profile) { Profile.create({ first_name: "Josue Luis", last_name: "Meza Peña" }) }

  it "must be invalid with empty data" do
    expect(empty_profile).to be_invalid
  end

  it "must be invalid with empty required values" do
    expect(empty_profile.errors[:first_name]).to include("can't be blank")
    expect(empty_profile.errors[:last_name]).to include("can't be blank")
  end

  it "must be invalid after trip values" do
    expect(not_strip_values_profile).to be_invalid
  end

  it "must be valid with correct values" do
    expect(valid_profile).to be_valid
    expect(valid_profile.full_name).to eq("#{valid_profile.first_name} #{valid_profile.last_name}")
  end

end
