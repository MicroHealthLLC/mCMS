FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password              "poipoipoi"
    password_confirmation "poipoipoi"
    sequence(:login) {|n| "user#{n}" }
    state true
  end

  factory :admin, :parent => :user do
    admin true
  end

  factory :case_manager, :parent => :user do
    admin false
    role FactoryGirl.create :case_manager_role
  end

  factory :client, :parent => :user do
    admin false
    role FactoryGirl.create :client_role
  end

end