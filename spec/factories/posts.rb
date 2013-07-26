# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "MyString"
    slug "MyString"
    description "MyText"
    abstract "MyText"
    body "MyText"
    published_at "2013-07-26 10:52:50"
  end
end
