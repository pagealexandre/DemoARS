require 'rails_helper'

RSpec.feature "user logs in" do

	before do
		#request.env["devise.mapping"] = Devise.mappings[:user]
		#request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google] 
	end

	scenario "using google auth" do
		visit '/sign_in'
		expect(page).to have_link("Sign in with Google")
		click_link "Sign in with Google"
	end
end