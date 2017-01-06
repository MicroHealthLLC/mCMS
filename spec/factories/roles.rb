FactoryGirl.define do
  factory :manager_role do
    id 1
    name "Manager role"
    state true
    note "MyText"
  end

   factory :client_role do
    id 2
    name "Client role"
    state true
    note "MyText"
  end


end
