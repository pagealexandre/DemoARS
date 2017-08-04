require "rails_helper"
require "json"

RSpec.describe RequestsController, :type => :controller do

	describe "GET #index" do

		it "responds successfully with an HTTP 200 status code" do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		let!(:reservation) { FactoryGirl.create(:reservation) }

		it "shows all the request" do
			get :index
			expect(assigns(:request)).to match(Request.all)
			json_answer = JSON.parse(response.body).first
			expect(reservation.offer_id).to eq json_answer["offer_id"]
			expect(reservation.guest).to eq json_answer["guest"]
			expect(reservation.host).to eq json_answer["host"]
			expect(reservation.status).to eq json_answer["status"]
		end
	end

end