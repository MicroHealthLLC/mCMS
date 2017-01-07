FactoryGirl.define do
  factory :enumeration do
    active true
    sequence(:name) {|n| "Enumerations #{n}"}
  end
end
