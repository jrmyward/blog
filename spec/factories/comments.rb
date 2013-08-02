# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body "MyText"
    email "MyString"
    site_url "MyString"
    user_ip "MyString"
    user_agent "MyString"
    referrer "MyString"
    approved false
  end
end
