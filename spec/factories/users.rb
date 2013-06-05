# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password '********'
    after(:build) do |user|
      user.accountings.build do |accounting|
        accounting.account = Account.first
      end
    end
  end
end
