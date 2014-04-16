# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :session do
    unique_id "MyString"
    identity_id 1
  end
end
