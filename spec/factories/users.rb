FactoryGirl.define do
  factory :admin, class: User do
    email 'admin@example.net'
    login 'admin'
    note nil
    state true
    admin true
    role_id nil
  end

  factory :user do
    email 'admin@example.net'
    login 'admin'
    note nil
    state true
    admin false
    role_id 2
  end

 factory :case_manager, class: User do
    email 'admin@example.net'
    login 'admin'
    note nil
    state true
    admin false
    role_id 1
  end


end
