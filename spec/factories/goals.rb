FactoryGirl.define do
  factory :goal do
    name "MyString"
    priority_type_id 1
    goal_status_id 1
    description "MyText"
    date_start "2016-12-24"
    date_due "2016-12-24"
    date_complete "2016-12-24"
    user_id 1
    case_id 1
  end
end
