FactoryGirl.define do
  factory :reservation, class: Reservation do
    guest Faker::Internet.email
    host Faker::Internet.email
    house_id Faker::Number.unique.between(1, 2147483648).number
    status 0
  end
end
