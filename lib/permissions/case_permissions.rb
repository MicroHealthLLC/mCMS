RedCarpet::AccessControl.map do |map|
# case user
  map.project_module :document do |map|
    map.permission :view_documents,   {:documents => [:index]},  :read => true
    map.permission :show_documents,   {:documents => [:show]},  :read => true
    map.permission :create_documents, {:documents => [:new, :create]},  :read => true
    map.permission :edit_documents,   {:documents => [ :edit, :update]},  :read => true
    map.permission :delete_documents, {:documents => [ :destroy]},  :read => true
    map.permission :manage_documents, {:documents => [:all_files, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :client_journal do |map|
    map.permission :view_client_journals,   {:client_journals => [:index, :show]},  :read => true
    map.permission :show_client_journals,   {:client_journals => [:show]},  :read => true
    map.permission :create_client_journals, {:client_journals => [:new, :create]},  :read => true
    map.permission :edit_client_journals,   {:client_journals => [ :edit, :update]},  :read => true
    map.permission :delete_client_journals, {:client_journals => [ :destroy]},  :read => true
    map.permission :manage_client_journals, {:client_journals => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :billings do |map|
    map.permission :view_billings,   {:billings => [:index, :show]},  :read => true
    map.permission :show_billings,   {:billings => [:show]},  :read => true
    map.permission :create_billings, {:billings => [:new, :create]},  :read => true
    map.permission :edit_billings,   {:billings => [ :edit, :update]},  :read => true
    map.permission :delete_billings, {:billings => [ :destroy]},  :read => true
    map.permission :manage_billings, {:billings => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :tasks do |map|
    map.permission :view_tasks, {:tasks => [:index]},  :read => true
    map.permission :show_tasks, {:tasks => [:show]},  :read => true
    map.permission :create_tasks, {:tasks => [:link_plan, :add_plan, :new, :create]},  :read => true
    map.permission :edit_tasks, {:tasks => [:edit, :update]},  :read => true
    map.permission :delete_tasks, {:tasks => [:destroy]},  :read => true
    map.permission :manage_tasks, {:tasks => [:link_plan, :add_plan, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :enrollments do |map|
    map.permission :view_enrollments, {:enrollments => [:index]},  :read => true
    map.permission :show_enrollments, {:enrollments => [:show]},  :read => true
    map.permission :create_enrollments, {:enrollments => [ :new, :create]},  :read => true
    map.permission :edit_enrollments, {:enrollments => [:edit, :update]},  :read => true
    map.permission :delete_enrollments, {:enrollments => [:destroy]},  :read => true
    map.permission :manage_enrollments, {:enrollments => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :related_clients do |map|
    map.permission :view_related_clients, {:related_clients => [:index]},  :read => true
    map.permission :show_related_clients, {:related_clients => [:show]},  :read => true
    map.permission :create_related_clients, {:related_clients => [ :new, :create]},  :read => true
    map.permission :edit_related_clients, {:related_clients => [:edit, :update]},  :read => true
    map.permission :delete_related_clients, {:related_clients => [:destroy]},  :read => true
    map.permission :manage_related_clients, {:related_clients => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :teleconsults do |map|
    map.permission :view_teleconsults, {:teleconsults => [:index]},  :read => true
    map.permission :show_teleconsults, {:teleconsults => [:show]},  :read => true
    map.permission :create_teleconsults, {:teleconsults => [ :new, :create]},  :read => true
    map.permission :edit_teleconsults, {:teleconsults => [:edit, :update]},  :read => true
    map.permission :delete_teleconsults, {:teleconsults => [:destroy]},  :read => true
    map.permission :manage_teleconsults, {:teleconsults => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :referrals do |map|
    map.permission :view_referrals, {:referrals => [:index]},  :read => true
    map.permission :show_referrals, {:referrals => [:show]},  :read => true
    map.permission :create_referrals, {:referrals => [ :find_organization, :new, :create]},  :read => true
    map.permission :edit_referrals, {:referrals => [:find_organization, :edit, :update]},  :read => true
    map.permission :delete_referrals, {:referrals => [:destroy]},  :read => true
    map.permission :manage_referrals, {:referrals => [:find_organization, :links, :add_referral, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :notes do |map|
    map.permission :view_notes, {:notes => [:index]},  :read => true
    map.permission :show_notes, {:notes => [:show]},  :read => true
    map.permission :add_notes, {:notes => [:get_template_note, :new, :create]},  :read => true
    map.permission :edit_notes, {:notes => [:get_template_note, :edit, :update]},  :read => true
    map.permission :delete_notes, {:notes => [:destroy]},  :read => true
    map.permission :manage_notes, {:notes => [:get_template_note, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :cases do |map|
    map.permission :view_cases, {:cases => [:index]},  :read => true
    map.permission :view_subcases, {:cases => [:subcases]},  :read => true
    map.permission :show_cases, {:cases => [:show]},  :read => true
    map.permission :my_cases, {:cases => [:my]},  :read => true
    map.permission :create_cases, {:cases => [:new, :create]},  :read => true
    map.permission :edit_cases, {:cases => [:edit, :update]},  :read => true
    map.permission :delete_cases, {:cases => [:destroy]},  :read => true
    map.permission :manage_cases, {:cases => [:subcases, :all_files, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :case_watchers do |map|
    map.permission :manage_watchers, {:case_watchers => [:index], :cases=> [:watchers]},  :read => true
  end

  map.project_module :case_supports do |map|
    map.permission :view_case_supports, {:case_supports => [:index]},  :read => true
    map.permission :show_case_supports, {:case_supports => [:show]},  :read => true
    map.permission :create_case_supports, {:case_supports => [:new, :create]},  :read => true
    map.permission :edit_case_supports, {:case_supports => [:remove, :edit, :update]},  :read => true
    map.permission :delete_case_supports, {:case_supports => [:destroy]},  :read => true
    map.permission :search_case_supports, {:case_supports => [:search]},  :read => true
    map.permission :manage_case_supports, {:case_supports => [:remove, :index, :show, :search, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :appointments do |map|
    map.permission :view_appointments, {:appointments => [:index]},  :read => true
    map.permission :show_appointments, {:appointments => [:show]},  :read => true
    map.permission :my_appointments, {:appointments => [:my]},  :read => true
    map.permission :create_appointments, {:appointments => [:new, :create]},  :read => true
    map.permission :edit_appointments, {:appointments => [:edit, :update]},  :read => true
    map.permission :delete_appointments, {:appointments => [:destroy]},  :read => true
    map.permission :manage_appointments, {:appointments => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
    map.permission :manage_assessment_and_diposition, {:appointment_captures => [:index, :show, :cms_form, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :surveys do |map|
    map.permission :view_surveys, {:surveys => [:index]},  :read => true
    map.permission :create_surveys, {:cases=>[:new_assign_survey], :surveys => [:new, :create]},  :read => true
    map.permission :edit_surveys, {:surveys => [:edit, :update]},  :read => true
    map.permission :delete_surveys, {:surveys => [:destroy]},  :read => true
    map.permission :manage_surveys, {:surveys => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
    map.permission :manage_attempts, {:cases=> [:new_assign_survey], :attempts => [:index, :show, :new, :create, :show]},  :read => true

  end

  map.project_module :needs do |map|
    map.permission :view_needs, {:needs => [:index]},  :read => true
    map.permission :show_needs, {:needs => [:show]},  :read => true
    map.permission :create_needs, {:needs => [:new, :create]},  :read => true
    map.permission :edit_needs, {:needs => [:add_goal, :edit, :update]},  :read => true
    map.permission :delete_needs, {:needs => [:destroy]},  :read => true
    map.permission :manage_needs, {:needs => [:links, :add_goal, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :goals do |map|
    map.permission :view_goals, {:goals => [:index]},  :read => true
    map.permission :show_goals, {:goals => [:show]},  :read => true
    map.permission :create_goals, {:goals => [:new, :create]},  :read => true
    map.permission :edit_goals, {:goals => [:link_need, :add_need, :links, :add_plan, :edit, :update]},  :read => true
    map.permission :delete_goals, {:goals => [:destroy]},  :read => true
    map.permission :manage_goals, {:goals => [:link_need, :add_need, :links, :add_plan, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :plans do |map|
    map.permission :view_plans, {:plans => [:index]},  :read => true
    map.permission :show_plans, {:plans => [:show]},  :read => true
    map.permission :create_plans, {:plans => [:new, :create]},  :read => true
    map.permission :edit_plans, {:plans => [:link_goal, :add_goal,:links, :add_action, :edit, :update]},  :read => true
    map.permission :delete_plans, {:plans => [:destroy]},  :read => true
    map.permission :manage_plans, {:plans => [:link_goal, :add_goal, :links, :add_action, :index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :checklists do |map|
    map.permission :view_checklists, {:checklist_cases => [:index, :show]},  :read => true
    map.permission :create_checklists, {:checklist_cases => [:new, :create], :cases=> [:new_assign]},  :read => true
    map.permission :edit_checklists, {:checklist_cases => [:edit, :update]},  :read => true
    map.permission :delete_checklists, {:checklist_cases => [:destroy]},  :read => true
    map.permission :manage_checklists, {:cases=> [:new_assign], :checklist_cases => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end
end