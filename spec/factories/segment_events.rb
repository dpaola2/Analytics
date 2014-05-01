# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :segment_event do
    segment_definition_id 1
    event_name "MyString"
  end
end
