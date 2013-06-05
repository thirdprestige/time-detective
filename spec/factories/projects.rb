# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    account do
      FactoryGirl.create(:account)
    end
  end

  factory :activity, class: 'Project::Activity' do
    worker do
      FactoryGirl.create(:user)
    end
  end
end
