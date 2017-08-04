FactoryGirl.define do
	factory :reservation, class: Request do
		guest "demoarsguest@gmail.com"
		host "demoarshost@gmail.com"
		offer_id Faker::Number.unique.between(1, 2147483648).number
	end
end