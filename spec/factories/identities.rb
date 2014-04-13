# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    session_id "MyString"
    userid "MyString"
    email "MyString"
    username "MyString"
    created "2014-04-13 14:34:59"
    event_id 1
  end
end
