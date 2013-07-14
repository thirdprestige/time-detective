# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :block do
    content "MyText"
    order 1
  end
end
