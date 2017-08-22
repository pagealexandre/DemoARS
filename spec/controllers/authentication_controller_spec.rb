require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do

	describe "GET #index" do

		it "Display the good template for authentication page" do
			get :index

			expect(response).to be_success
			expect(response).to have_http_status(200)
			expect(response).to render_template(:index)
		end
	end

	describe "POST #authenticate_user" do

		let!(:user) { FactoryGirl.create(:user) }

		context "Good credential" do

			it "Authenticate user" do
				expected_token = JsonWebToken.encode({user_id: user.id})
				expected_user = "{'id'=>#{user.id}, 'email'=>'#{user.email}'}".as_json

				post :authenticate_user, :params => { email: user.email, password: user.password }
				parsed_response = JSON.parse(response.body)
				expect(parsed_response['auth_token']).to eq expected_token
				expect(parsed_response['user']['id']).to eq user.id
				expect(parsed_response['user']['email']).to eq user.email
			end

		end

		context "Wrong credential" do

			it "Display an error message" do
				post :authenticate_user, :params => { email: Faker::Internet.email, password: Faker::Internet.password }
				parsed_response = JSON.parse(response.body)
				expect(parsed_response['errors']).to eq ["Invalid Username/Password"]
			end
		end

	end

	describe "POST #create (OAuth 2.0) with Google" do

		before do
			request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
  			request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google] 
		end

		it "Create or update a user and a authentication cookie" do
			
		end

	end

end
