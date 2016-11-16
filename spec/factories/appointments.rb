FactoryGirl.define do
  factory :appointment do
    title "MyString"
    description "MyText"
    appointment_type_id 1
    date "2016-11-16 12:23:47"
    appointment_status_id 1
    user_id 1
    with_who_id 1
    with_who_type "MyString"
  end
end
