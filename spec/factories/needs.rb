FactoryGirl.define do
  factory :need do
    need_enum_id 1
    priority_id 1
    need_status_id 1
    description "MyText"
    date_due "2016-12-24"
    date_complete "2016-12-24"
    user_id 1
  end
end
