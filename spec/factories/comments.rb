# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :comment do
    name Faker::Name.name
    email Faker::Internet.email
    body "Hello World"
    site_url 'example.com'
  end
end
