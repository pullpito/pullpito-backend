require 'rails_helper'
include ActionController::RespondWith

RSpec.describe DeviseTokenAuth::SessionsController, type: :request do
    let(:user) { FactoryBot.create(:user) }

    describe "Login/Logout" do
        context "on success" do
            before { post user_session_path(), params: login_params(from: user) }

            it "should return success on login with a valid user" do
                expect(response).to have_http_status(:success)
            end
    
            it "should return success on logout with a valid token" do
                delete destroy_user_session_path(), headers: headers(from: response)
                expect(response).to have_http_status(:success)
            end
        end

        context "on failure" do
            it "should be disabled login with GET method" do
                get new_user_session_path()
                expect(response).to have_http_status(:method_not_allowed)
            end
    
            it "should return unauthorized on login with empty values" do
                post user_session_path()
                expect(response).to have_http_status(:unauthorized)
            end

            it "should return unauthorized on login with incorrect credentials" do
                post user_session_path(), params: login_params(from: user, password: "any")
                expect(response).to have_http_status(:unauthorized)
            end

            it "should return not found on logout with incorrect token" do
                post user_session_path(), params: login_params(from: user)
                delete destroy_user_session_path(), headers: headers(from: response, access_token: "any")
                expect(response).to have_http_status(:not_found)
            end
        end
    end
end