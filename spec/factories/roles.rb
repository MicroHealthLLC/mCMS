FactoryGirl.define do
  factory :role do
    state true
  end

  factory :case_manager_role, :parent => :role do
    role_type_id 21
    permissions [:manage_roles]
  end

  factory :client_role, :parent => :role do
    role_type_id 25
  end

end
