FactoryGirl.define do
  factory :appointment_capture do
    user_id 1
    appointment_id 1
    assessment_id 1
    disposition_id 1
    procedure_id 1
    note "MyText"
  end
end
