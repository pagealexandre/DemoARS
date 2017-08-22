require 'rails_helper'

RSpec.describe "Cron job", type: :request do

		context "The reservation has expired" do

		let(:schedule) { Whenever::Test::Schedule.new(file: 'config/schedule.rb') }
		let!(:expired_reservation) { FactoryGirl.create(:reservation, :created_at => 1.days.ago) }
		let!(:reservation) { FactoryGirl.create(:reservation) }

		it "make sure runner statement exist" do
			assert_equal 1, schedule.jobs[:runner].count
		end

		it "send an email to both the guest and host" do
			schedule.jobs[:runner].each { |job| instance_eval job[:task] }
			email = ActionMailer::Base.deliveries.first

			expect(ActionMailer::Base.deliveries.count).to eq(1)
			expect(email.subject).to eq "Your reservation has expired"
			expect(email.to).to eq [expired_reservation.guest, expired_reservation.host]
		end

		it "remove expired reservation" do
			allow_any_instance_of(ApplicationController).to receive(:authenticate_request!).and_return(FactoryGirl.create(:user))
			schedule.jobs[:runner].each { |job| instance_eval job[:task] }
			get '/reservations'
			json_response = response.body
			expect(json_response).to be_json_eql([reservation].to_json)
		end
	end

end