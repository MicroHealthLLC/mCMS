FactoryGirl.define do
  factory :plan do
    name "MyString"
    priority_type_id 1
    plan_status_id 1
    description "MyText"
    date_start "2016-12-24"
    date_due "2016-12-24"
    date_completed "2016-12-24"
    user_id 1
    case_id 1
  end
end
