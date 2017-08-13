require 'rails_helper'

RSpec.describe Reservation, type: :model do
	subject { Reservation.new(guest: Faker::Internet.unique.email, host: Faker::Internet.unique.email,
	 house_id: Faker::Number.unique.between(1, 2147483648).number) }
 
 	describe "Validations" do

 		it "is valid with valid attributes" do
 			expect(subject).to be_valid
 		end

 		it "is not valid without a guest" do
 			subject.guest = nil
 			expect(subject).to_not be_valid
 		end

 		it "is not valid without host" do
 			subject.host = nil
 			expect(subject).to_not be_valid
 		end

 		it "is not valid without house_id" do
 			subject.house_id = nil
 			expect(subject).to_not be_valid
 		end
 	end

end
