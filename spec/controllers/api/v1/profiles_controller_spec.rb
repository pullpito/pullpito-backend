require 'rails_helper'

RSpec.describe Api::V1::ProfilesController, type: :request do
  let(:current_user) { FactoryBot.create(:user) }
  let(:profiles) { FactoryBot.create_list(:profile, 10) }
  before { post user_session_path(), params: login_params(from: current_user) }

  describe "GET /api/v1/profiles/:id" do
    context "on success" do
      let(:profile) { profiles.sample }
      before { get api_v1_profile_path(profile.id), headers: headers(from: response) }
  
      it "should return http success" do
        expect(response).to have_http_status(:success)
      end
  
      it "should return required fields" do
        expect(JSON.parse(response.body).keys).to include("first_name", "last_name", "full_name")
      end

      it "should return correct values" do
        json = JSON.parse(response.body)
        expect(json["id"]).to eq(profile.id)
        expect(json["first_name"]).to eq(profile.first_name)
        expect(json["last_name"]).to eq(profile.last_name)
      end
    end

    context "on failure" do
      before { get api_v1_profile_path(profiles.count + 1), headers: headers(from: response) }
  
      it "should return http not found" do
        expect(response).to have_http_status(:not_found)
      end
  
      it "should return an error message" do
        expect(JSON.parse(response.body)["error"]).to include(not_found)
      end
    end
  end

end
