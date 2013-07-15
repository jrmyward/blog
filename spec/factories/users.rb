# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'Peter'
    last_name 'Parker'
    sequence(:email) {|n| "superhero-#{n}@example.com" }
    password 'foobar'
    password_confirmation 'foobar'
  end
end
