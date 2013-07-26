# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "Hello World"
    description "The world is round."
    abstract "People used to think the world was flat."
    body "People used to think the world was flat. The world is actually a sphere."
    published_at Time.now.utc
  end
end
