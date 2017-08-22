require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do

	before :each do |example|
		unless example.metadata[:skip_auth]
			allow(controller).to receive(:authenticate_request!).and_return(FactoryGirl.create(:user))
		end
	end

	context "Unauthorized request", skip_auth: true do

		let!(:reservation) { FactoryGirl.create(:reservation) }

		it "Shows not authorized error message for GET #index" do
			get :index
			parsed_response = JSON.parse(response.body)

			expect(response).to have_http_status(:unauthorized)
			expect(parsed_response['errors']).to eq ["Not Authenticated"]
		end

		it "Shows not authorized error message for GET #show" do
			get :show, :params => {id: reservation.id}
			parsed_response = JSON.parse(response.body)

			expect(response).to have_http_status(:unauthorized)
			expect(parsed_response['errors']).to eq ["Not Authenticated"]
		end

		it "Shows not authorized error message for POST #create" do
			post :create, :params => { guest: reservation.guest, host: reservation.host, house_id: reservation.house_id }
			parsed_response = JSON.parse(response.body)

			expect(response).to have_http_status(:unauthorized)
			expect(parsed_response['errors']).to eq ["Not Authenticated"]
		end

		it "Shows not authorized error message for PUT #update" do
			put :update, :params => {:id => reservation.id, :status => 1}
			parsed_response = JSON.parse(response.body)

			expect(response).to have_http_status(:unauthorized)
			expect(parsed_response['errors']).to eq ["Not Authenticated"]
		end

		it "Shows not authorized error message for DELETE #destroy" do
			delete :destroy, :params => { :id => reservation.id}
			parsed_response = JSON.parse(response.body)

			expect(response).to have_http_status(:unauthorized)
			expect(parsed_response['errors']).to eq ["Not Authenticated"]
		end

	end

	describe "GET #index" do

		let!(:reservations) { FactoryGirl.create_list(:reservation, 5) }

		it "shows all the request" do
			get :index
			reservations = Reservation.all

			expect(response).to be_success
			expect(response).to have_http_status(200)
			expect(response.body).to be_json_eql(reservations.to_json)
		end
	end

	describe "GET #show" do

		let!(:reservation) { FactoryGirl.create(:reservation) }

		it "shows the corresponding reservation" do
			get :show, :params => {id: reservation.id}

			expect(response).to be_success
			expect(response).to have_http_status(200)
			expect(response.body).to be_json_eql(reservation.to_json)
		end
	end

	describe "POST #create" do

		let!(:reservation) { FactoryGirl.create(:reservation) }

		after(:each) do
  			ActionMailer::Base.deliveries.clear
		end

		it "create successfully a ressource" do
			post :create, :params => { guest: reservation.guest, host: reservation.host, house_id: reservation.house_id }

			expect(response.body).to be_json_eql(reservation.to_json)
			expect(response).to be_success
			expect(response).to have_http_status(201)

		end

		it "send an email to the host and guest" do
			post :create, :params => { guest: reservation.guest, host: reservation.host, house_id: reservation.house_id }
			mail_to_host = ActionMailer::Base.deliveries.first
			mail_to_guest = ActionMailer::Base.deliveries.last

			expect(ActionMailer::Base.deliveries.count).to eq(2)
			expect(mail_to_host.subject).to eq "Someone is interested in your house"
			expect(mail_to_host.to).to eq [reservation.host]
			expect(mail_to_guest.subject).to eq "Request confirmation"
			expect(mail_to_guest.to).to eq [reservation.guest]
		end

		context "Missing parameter" do

			before do
				allow_any_instance_of(ApplicationController).to receive(:render_unprocessable_entity_response).and_raise(ActiveRecord::RecordInvalid)
			end

			it "raise an ActiveRecord::RecordInvalid exception" do
				expect{ 
					post :create, :params => { guest: reservation.guest, host: reservation.host }
				}.to raise_error(ActiveRecord::RecordInvalid)
			end
		end

	end

	describe "PUT #update" do

		before(:each) do
			@reservation = FactoryGirl.create(:reservation)
		end

		after(:each) do
  			ActionMailer::Base.deliveries.clear
		end

		context "The guest cancel the reservation" do

			before(:each) do
				put :update, :params => {:id => @reservation.id, :status => 1}
				@json_response = response.body
			end

			it "should send an email to the guest" do
				email_to_host = ActionMailer::Base.deliveries.first

				expect(ActionMailer::Base.deliveries.count).to eq(1)
				expect(email_to_host.subject).to eq "The guest has cancel his request"
				expect(email_to_host.to).to eq [@reservation.host]
			end

			it "display the updated reservation" do
				reservation = Reservation.find(@reservation.id)
				expect(@json_response).to be_json_eql(reservation.to_json)
			end

		end

		context "The host decline the reservation" do

			before(:each) do
				put :update, :params => {:id => @reservation.id, :status => 2}
				@json_response = response.body
			end

			it "send an email to the guest" do
				email_to_guest = ActionMailer::Base.deliveries.first

				expect(ActionMailer::Base.deliveries.count).to eq(1)
				expect(email_to_guest.subject).to eq "The host has decline your request reservation"
				expect(email_to_guest.to).to eq [@reservation.guest]
			end

			it "display the updated reservation" do
				reservation = Reservation.find(@reservation.id)
				expect(@json_response).to be_json_eql(reservation.to_json)
			end

		end

		context "The host accept the reservation" do

			before(:each) do
				put :update, :params => {:id => @reservation.id, :status => 3}
				@json_response = response.body
			end			

			it "send an email to both the host and guest" do
				email = ActionMailer::Base.deliveries.first

				expect(ActionMailer::Base.deliveries.count).to eq(1)
				expect(email.subject).to eq "Confirmation reservation"
				expect(email.to).to eq [@reservation.guest, @reservation.host]
			end


			it "display the updated reservation" do
				reservation = Reservation.find(@reservation.id)
				expect(@json_response).to be_json_eql(reservation.to_json)
			end

		end

	end

	describe "DELETE #destroy" do

		let!(:reservation) { FactoryGirl.create(:reservation) }

		it "removes successfully a reservation" do
			delete :destroy, :params => { :id => reservation.id}
			@json_response = response.body

			expect(response).to be_success
			expect(response).to have_http_status(204)
			expect(response.body).to eq("")
		end
	end

end
