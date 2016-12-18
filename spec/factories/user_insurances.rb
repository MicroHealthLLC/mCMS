FactoryGirl.define do
  factory :user_insurance do
    user_id 1
    insurance_id 1
    insurance_type_id 1
    insurance_identifier "MyString"
    note "MyText"
  end
end
