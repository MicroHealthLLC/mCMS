require 'red_carpet/access_control'


# Permissions
RedCarpet::AccessControl.map do |map|
  # profile user
  map.project_module :educations do |map|
    map.permission :view_educations,   {:educations => [:index]},  :read => true
    map.permission :show_educations,   {:educations => [:show]},  :read => true
    map.permission :create_educations, {:educations => [:new, :create]},  :read => true
    map.permission :edit_educations,   {:educations => [:edit, :update]},  :read => true
    map.permission :delete_educations, {:educations => [ :destroy]},  :read => true
    map.permission :manage_educations, {:educations => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :languages do |map|
    map.permission :view_languages, {:languages => [:index]},  :read => true
    map.permission :show_languages, {:languages => [:show]},  :read => true
    map.permission :create_languages, {:languages => [:new, :create]},  :read => true
    map.permission :edit_languages, {:languages => [:edit, :update]},  :read => true
    map.permission :delete_languages, {:languages => [:destroy]},  :read => true
    map.permission :manage_languages, {:languages => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :affiliations do |map|
    map.permission :view_affiliations, {:affiliations => [:index]},  :read => true
    map.permission :show_affiliations, {:affiliations => [:show]},  :read => true
    map.permission :create_affiliations, {:affiliations => [:new, :create]},  :read => true
    map.permission :edit_affiliations, {:affiliations => [:edit, :update]},  :read => true
    map.permission :delete_affiliations, {:affiliations => [:destroy]},  :read => true
    map.permission :manage_affiliations, {:affiliations => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :positions do |map|
    map.permission :view_positions, {:positions => [:index]},  :read => true
    map.permission :show_positions, {:positions => [:show]},  :read => true
    map.permission :create_positions, {:positions => [:new, :create]},  :read => true
    map.permission :edit_positions, {:positions => [:edit, :update]},  :read => true
    map.permission :delete_positions, {:positions => [:destroy]},  :read => true
    map.permission :manage_positions, {:positions => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :contacts do |map|
    map.permission :view_contacts, {:contacts => [:index]},  :read => true
    map.permission :show_contacts, {:contacts => [:show]},  :read => true
    map.permission :search_contact, {:contacts => [:search]},  :read => true
    map.permission :create_contacts, {:contacts => [:new, :create]},  :read => true
    map.permission :edit_contacts, {:contacts => [:remove, :edit, :update]},  :read => true
    map.permission :delete_contacts, {:contacts => [:destroy]},  :read => true
    map.permission :manage_contacts, {:contacts => [:remove, :index, :show, :search, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :certifications do |map|
    map.permission :view_certifications, {:certifications => [:index]},  :read => true
    map.permission :show_certifications, {:certifications => [:show]},  :read => true
    map.permission :create_certifications, {:certifications => [:new, :create]},  :read => true
    map.permission :edit_certifications, {:certifications => [:edit, :update]},  :read => true
    map.permission :delete_certifications, {:certifications => [:destroy]},  :read => true
    map.permission :manage_certifications, {:certifications => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :clearances do |map|
    map.permission :view_clearances, {:clearances => [:index]},  :read => true
    map.permission :show_clearances, {:clearances => [:show]},  :read => true
    map.permission :create_clearances, {:clearances => [:new, :create]},  :read => true
    map.permission :edit_clearances, {:clearances => [:edit, :update]},  :read => true
    map.permission :delete_clearances, {:clearances => [:destroy]},  :read => true
    map.permission :manage_clearances, {:clearances => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :insurances do |map|
    map.permission :view_insurance, {:user_insurances => [:index]},  :read => true
    map.permission :show_insurance, {:user_insurances => [:show]},  :read => true
    map.permission :create_insurance, {:user_insurances => [:new, :create]},  :read => true
    map.permission :edit_insurance, {:user_insurances => [:edit, :update]},  :read => true
    map.permission :delete_insurance, {:user_insurances => [:destroy]},  :read => true
    map.permission :manage_insurance, {:user_insurances => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :other_skills do |map|
    map.permission :view_other_skills, {:other_skills => [:index]},  :read => true
    map.permission :show_other_skills, {:other_skills => [:show]},  :read => true
    map.permission :create_other_skills, {:other_skills => [:new, :create]},  :read => true
    map.permission :edit_other_skills, {:other_skills => [:edit, :update]},  :read => true
    map.permission :delete_other_skills, {:other_skills => [:destroy]},  :read => true
    map.permission :manage_other_skills, {:other_skills => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end



  # map.project_module :departments do |map|
  #   map.permission :view_departments,   {:departments => [:index]},  :read => true
  #   map.permission :create_departments, {:departments => [:new, :create]},  :read => true
  #   map.permission :edit_departments,   {:departments => [:edit, :update]},  :read => true
  #   map.permission :delete_departments, {:departments => [:destroy]},  :read => true
  #   map.permission :manage_departments, {:departments => [:new, :create, :edit, :update, :destroy]},  :read => true
  # end
  #
  # map.project_module :organizations do |map|
  #   map.permission :view_organizations, {:organizations => [:index]},  :read => true
  #   map.permission :create_organizations, {:organizations => [:new, :create]},  :read => true
  #   map.permission :edit_organizations, {:organizations => [:edit, :update]},  :read => true
  #   map.permission :delete_organizations, {:organizations => [:destroy]},  :read => true
  #   map.permission :manage_organizations, {:organizations => [:new, :create, :edit, :update, :destroy]},  :read => true
  # end
  
  # User HISTORY

  map.project_module :daily_livings do |map|
    map.permission :view_daily_livings, {:daily_livings => [:index]},  :read => true
    map.permission :show_daily_livings, {:daily_livings => [:show]},  :read => true
    map.permission :create_daily_livings, {:daily_livings => [:new, :create]},  :read => true
    map.permission :edit_daily_livings, {:daily_livings => [:edit, :update]},  :read => true
    map.permission :delete_daily_livings, {:daily_livings => [:destroy]},  :read => true
    map.permission :manage_daily_livings, {:daily_livings => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :financials do |map|
    map.permission :view_financials, {:financials => [:index]},  :read => true
    map.permission :show_financials, {:financials => [:show]},  :read => true
    map.permission :create_financials, {:financials => [:new, :create]},  :read => true
    map.permission :edit_financials, {:financials => [:edit, :update]},  :read => true
    map.permission :delete_financials, {:financials => [:destroy]},  :read => true
    map.permission :manage_financials, {:financials => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

   map.project_module :transportations do |map|
    map.permission :view_transportations, {:transportations => [:index]},  :read => true
    map.permission :show_transportations, {:transportations => [:show]},  :read => true
    map.permission :create_transportations, {:transportations => [:new, :create]},  :read => true
    map.permission :edit_transportations, {:transportations => [:edit, :update]},  :read => true
    map.permission :delete_transportations, {:transportations => [:destroy]},  :read => true
    map.permission :manage_transportations, {:transportations => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

    map.project_module :legals do |map|
    map.permission :view_legals, {:legals => [:index]},  :read => true
    map.permission :show_legals, {:legals => [:show]},  :read => true
    map.permission :create_legals, {:legals => [:new, :create]},  :read => true
    map.permission :edit_legals, {:legals => [:edit, :update]},  :read => true
    map.permission :delete_legals, {:legals => [:destroy]},  :read => true
    map.permission :manage_legals, {:legals => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :admissions do |map|
    map.permission :view_admissions, {:admissions => [:index]},  :read => true
    map.permission :show_admissions, {:admissions => [:show]},  :read => true
    map.permission :create_admissions, {:admissions => [:new, :create]},  :read => true
    map.permission :edit_admissions, {:admissions => [ :edit, :update]},  :read => true
    map.permission :delete_admissions, {:admissions => [:destroy]},  :read => true
    map.permission :manage_admissions, {:admissions => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :health_care_facilities do |map|
    map.permission :view_health_care_facilities, {:health_care_facilities => [:index]},  :read => true
    map.permission :show_health_care_facilities, {:health_care_facilities => [:show]},  :read => true
    map.permission :create_health_care_facilities, {:health_care_facilities => [:new, :create]},  :read => true
    map.permission :edit_health_care_facilities, {:health_care_facilities => [ :edit, :update]},  :read => true
    map.permission :delete_health_care_facilities, {:health_care_facilities => [:destroy]},  :read => true
    map.permission :manage_health_care_facilities, {:health_care_facilities => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :housings do |map|
    map.permission :view_housings, {:housings => [:index]},  :read => true
    map.permission :show_housings, {:housings => [:show]},  :read => true
    map.permission :create_housings, {:housings => [:new, :create]},  :read => true
    map.permission :edit_housings, {:housings => [ :edit, :update]},  :read => true
    map.permission :delete_housings, {:housings => [:destroy]},  :read => true
    map.permission :manage_housings, {:housings => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  # MILITARY HISTORY
  map.project_module :service_histories do |map|
    map.permission :view_service_histories, {:service_histories => [:index]},  :read => true
    map.permission :show_service_histories, {:service_histories => [:show]},  :read => true
    map.permission :create_service_histories, {:service_histories => [:new, :create]},  :read => true
    map.permission :edit_service_histories, {:service_histories => [ :edit, :update]},  :read => true
    map.permission :delete_service_histories, {:service_histories => [:destroy]},  :read => true
    map.permission :manage_service_histories, {:service_histories => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :units do |map|
    map.permission :view_units, {:units => [:index]},  :read => true
    map.permission :show_units, {:units => [:show]},  :read => true
    map.permission :create_units, {:units => [:new, :create]},  :read => true
    map.permission :edit_units, {:units => [ :edit, :update]},  :read => true
    map.permission :delete_units, {:units => [:destroy]},  :read => true
    map.permission :manage_units, {:units => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :awards do |map|
    map.permission :view_awards, {:awards => [:index]},  :read => true
    map.permission :show_awards, {:awards => [:show]},  :read => true
    map.permission :create_awards, {:awards => [:new, :create]},  :read => true
    map.permission :edit_awards, {:awards => [ :edit, :update]},  :read => true
    map.permission :delete_awards, {:awards => [:destroy]},  :read => true
    map.permission :manage_awards, {:awards => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :deployment_histories do |map|
    map.permission :view_deployment_histories, {:deployment_histories => [:index]},  :read => true
    map.permission :show_deployment_histories, {:deployment_histories => [:show]},  :read => true
    map.permission :create_deployment_histories, {:deployment_histories => [:new, :create]},  :read => true
    map.permission :edit_deployment_histories, {:deployment_histories => [ :edit, :update]},  :read => true
    map.permission :delete_deployment_histories, {:deployment_histories => [:destroy]},  :read => true
    map.permission :manage_deployment_histories, {:deployment_histories => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :incident_histories do |map|
    map.permission :view_incident_histories, {:incident_histories => [:index]},  :read => true
    map.permission :show_incident_histories, {:incident_histories => [:show]},  :read => true
    map.permission :create_incident_histories, {:incident_histories => [:new, :create]},  :read => true
    map.permission :edit_incident_histories, {:incident_histories => [ :edit, :update]},  :read => true
    map.permission :delete_incident_histories, {:incident_histories => [:destroy]},  :read => true
    map.permission :manage_incident_histories, {:incident_histories => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :mtf_hospitals do |map|
    map.permission :view_mtf_hospitals, {:mtf_hospitals => [:index]},  :read => true
    map.permission :show_mtf_hospitals, {:mtf_hospitals => [:show]},  :read => true
    map.permission :create_mtf_hospitals, {:mtf_hospitals => [:new, :create]},  :read => true
    map.permission :edit_mtf_hospitals, {:mtf_hospitals => [ :edit, :update]},  :read => true
    map.permission :delete_mtf_hospitals, {:mtf_hospitals => [:destroy]},  :read => true
    map.permission :manage_mtf_hospitals, {:mtf_hospitals => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end





  # case user
  map.project_module :document do |map|
    map.permission :view_documents,   {:documents => [:index]},  :read => true
    map.permission :show_documents,   {:documents => [:show]},  :read => true
    map.permission :create_documents, {:documents => [:new, :create]},  :read => true
    map.permission :edit_documents,   {:documents => [ :edit, :update]},  :read => true
    map.permission :delete_documents, {:documents => [ :destroy]},  :read => true
    map.permission :manage_documents, {:documents => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :client_journal do |map|
    map.permission :view_client_journals,   {:client_journals => [:index]},  :read => true
    map.permission :show_client_journals,   {:client_journals => [:show]},  :read => true
    map.permission :create_client_journals, {:client_journals => [:new, :create]},  :read => true
    map.permission :edit_client_journals,   {:client_journals => [ :edit, :update]},  :read => true
    map.permission :delete_client_journals, {:client_journals => [ :destroy]},  :read => true
    map.permission :manage_client_journals, {:client_journals => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :news do |map|
    map.permission :view_news, {:news => [:index]}, :read => true
    map.permission :show_news, {:news => [:show]}, :read => true
    map.permission :create_news, {:news => [:new, :create]}, :read => true
    map.permission :edit_news, {:news => [:edit, :update]}, :read => true
    map.permission :delete_news, {:news => [:destroy]}, :read => true
    map.permission :manage_news, {:news => [:index, :show, :new, :create, :edit, :update, :destroy]}, :read => true
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

  map.project_module :teleconsults do |map|
    map.permission :view_teleconsults, {:teleconsults => [:index]},  :read => true
    map.permission :show_teleconsults, {:teleconsults => [:show]},  :read => true
    map.permission :create_teleconsults, {:teleconsults => [ :new, :create]},  :read => true
    map.permission :edit_teleconsults, {:teleconsults => [:edit, :update]},  :read => true
    map.permission :delete_teleconsults, {:teleconsults => [:destroy]},  :read => true
    map.permission :manage_teleconsults, {:teleconsults => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
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
    map.permission :manage_assessment_and_diposition, {:appointment_captures => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :surveys do |map|
    map.permission :view_surveys, {:surveys => [:index]},  :read => true
    map.permission :create_surveys, {:cases=>[:new_assign_survey], :surveys => [:new, :create]},  :read => true
    map.permission :edit_surveys, {:surveys => [:edit, :update]},  :read => true
    map.permission :delete_surveys, {:surveys => [:destroy]},  :read => true
    map.permission :manage_surveys, {:surveys => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
    map.permission :manage_attempts, {:cases=> [:new_assign_survey], :attempts => [:index, :show, :new, :create, :show]},  :read => true

  end

  map.project_module :wikis do |map|
    map.permission :manage_wikis, {:wikis => [:index, :show, :new, :show, :create, :edit, :update, :history, :compare, :add_attachment, :destroy]},  :read => true
  end

  map.project_module :needs do |map|
    map.permission :view_needs, {:needs => [:index]},  :read => true
    map.permission :show_needs, {:needs => [:show]},  :read => true
    map.permission :create_needs, {:needs => [:new, :create]},  :read => true
    map.permission :edit_needs, {:needs => [:links, :add_goal, :edit, :update]},  :read => true
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
     map.permission :view_checklists, {:checklist_cases => [:index]},  :read => true
     map.permission :create_checklists, {:checklist_cases => [:new, :create], :cases=> [:new_assign]},  :read => true
     map.permission :edit_checklists, {:checklist_cases => [:edit, :update]},  :read => true
     map.permission :delete_checklists, {:checklist_cases => [:destroy]},  :read => true
     map.permission :manage_checklists, {:cases=> [:new_assign], :checklist_cases => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :chat_room do |map|
    map.permission :make_chat, {:chat_rooms => [:create_or_find, :show]},  :read => true
    map.permission :conference, {:chat_rooms => [:conference]},  :read => true
  end



  map.project_module :employee do |map|
    map.permission :manage_roles, {
        :employees => [:index],
        :educations => [:index, :show, :new, :create, :edit, :update, :destroy],
        :languages => [:index, :show, :new, :create, :edit, :update, :destroy],
        :daily_livings => [:index, :show, :new, :create, :edit, :update, :destroy],
        :affiliations => [:index, :show, :new, :create, :edit, :update, :destroy],
        :clearances => [:index, :show, :new, :create, :edit, :update, :destroy],
        :user_insurances => [:index, :show, :new, :create, :edit, :update, :destroy],
        :certifications => [:index, :show, :new, :create, :edit, :update, :destroy],
        :contacts => [:search, :index, :show, :new, :create, :edit, :update, :destroy, :remove],
        :chat_rooms => [:conference, :show, :create_or_find],
        :document => [:index,:new,  :show, :create, :edit, :update, :destroy],
        :other_skills => [:index,:new,  :show, :create, :edit, :update, :destroy],
        :positions => [:index, :show, :new, :create, :edit, :update, :destroy],
        :admissions => [:index, :show, :new, :create, :edit, :update, :destroy],
        :housings => [:index, :show, :new, :create, :edit, :update, :destroy],
        :service_histories => [:index, :show, :new, :create, :edit, :update, :destroy],
        :units => [:index, :show, :new, :create, :edit, :update, :destroy],
        :awards => [:index, :show, :new, :create, :edit, :update, :destroy],
        :deployment_histories => [:index, :show, :new, :create, :edit, :update, :destroy],
        :incident_histories => [:index, :show, :new, :create, :edit, :update, :destroy],
        :mtf_hospitals => [:index, :show, :new, :create, :edit, :update, :destroy],
        :health_care_facilities => [:index, :show, :new, :create, :edit, :update, :destroy],
        :teleconsults => [:index, :show, :new, :create, :edit, :update, :destroy],
        :legals => [:index, :show, :new, :create, :edit, :update, :destroy],
        :financials => [:index, :show, :new, :create, :edit, :update, :destroy],
        :transportations => [:index, :show, :new, :create, :edit, :update, :destroy],
        :surveys => [:new_assign_survey, :index, :show, :new, :create, :edit, :update, :destroy, :show],
        :attempts => [:index, :show, :new, :create, :show],
        :tasks => [:link_plan, :add_plan, :index, :my, :show, :new, :create, :edit, :update, :destroy],
        :cases => [:new_assign, :my, :all_files, :subcases, :watchers, :index, :show, :new, :create, :edit, :update, :destroy],
        :case_supports => [:search, :index, :show, :new, :create, :edit, :update, :destroy],
        :case_watchers => [:index],
        :appointments => [:my, :index, :show, :new, :create, :edit, :update, :destroy],
        :appointment_captures => [:show, :new, :create, :edit, :update, :destroy],
        :needs => [:links, :add_goal,:index, :show, :new, :create, :edit, :update, :destroy],
        :news => [:index, :show, :new, :create, :edit, :update, :destroy],
        :notes => [:index, :show, :new, :create, :edit, :update, :destroy, :get_template_note],
        :plans => [:link_goal, :add_goal,:links, :add_action, :index, :show, :new, :create, :edit, :update, :destroy],
        :goals => [:link_need, :add_need, :links, :add_plan, :index, :show, :new, :create, :edit, :update, :destroy],
        :checklist_cases => [:index, :show, :new, :create, :edit, :update, :destroy],
        :wikis => [:new, :index, :show, :create, :edit, :update, :history, :compare, :add_attachment, :destroy]

    },  :read => true
  end
end
