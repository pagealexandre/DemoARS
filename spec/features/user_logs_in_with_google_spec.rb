require 'rails_helper'

RSpec.feature "user logs in" do

	scenario "using google auth" do
		visit '/sign_in'
		expect(page).to have_link("Sign in with Google")
		click_link "Sign in with Google"
		expect(page).to have_content("demoarsguest@gmail.com")
		expect(page).to have_link("Logout")
		expect(get_me_the_cookie("Authorization")[:value]).to eq "Bearer wcAQPJTr4CeTGwL6CfFo"
	end

end