require 'rails_helper'
include ActionController::RespondWith

RSpec.describe DeviseTokenAuth::SessionsController, type: :request do
    context "Login/Logout" do

        it "must be disabled login with GET method" do
            get new_user_session_path()
            expect(response).to have_http_status(:method_not_allowed)
        end

        it "must return unauthorized on login with empty values" do
            post user_session_path()
            expect(response).to have_http_status(:unauthorized)
        end

        it "must return unauthorized on login with incorrect credentials" do
            user = User.create!({ email: "test@example.com", password: "password" })
            post user_session_path(), params: { email: "test2@example.com", password: "password" }
            expect(response).to have_http_status(:unauthorized)
        end

        it "must return not found on logout with incorrect token" do
            user = User.create!({ email: "test@example.com", password: "password" })
            post user_session_path(), params: { email: "test@example.com", password: "password" }
            delete destroy_user_session_path(), headers: { 
                'access-token' => response.header['access-token'] + "bad value",
                'client' => response.header['client'],
                'uid' => response.header['uid']
            }
            expect(response).to have_http_status(:not_found)
        end

        it "must return success on login with a valid user" do
            user = User.create!({ email: "test@example.com", password: "password" })
            post user_session_path(), params: { email: "test@example.com", password: "password" }
            expect(response).to have_http_status(:success)
        end

        it "must return success on logout with a valid token" do
            user = User.create!({ email: "test@example.com", password: "password" })
            post user_session_path(), params: { email: "test@example.com", password: "password" }
            delete destroy_user_session_path(), headers: { 
                'access-token' => response.header['access-token'],
                'client' => response.header['client'],
                'uid' => response.header['uid']
            }
            expect(response).to have_http_status(:success)
        end

    end
end