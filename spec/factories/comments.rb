# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    name "Doctor Doom"
    email Faker::Internet.email
    body "Hello World"
    site_url 'example.com'
    is_commentable true
  end
end
