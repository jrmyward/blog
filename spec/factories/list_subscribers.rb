require 'faker'

FactoryGirl.define do
  factory :list_subscriber do
    email Faker::Internet.email
    first_name Faker::Name.first_name
    confirmed false
  end
end
