# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cohort do
    name "MyString"
    time_bucket "MyString"
    segment_definition_id 1
  end
end
