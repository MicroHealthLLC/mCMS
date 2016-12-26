require 'red_carpet/access_control'


# Permissions
RedCarpet::AccessControl.map do |map|
  # profile user
  map.project_module :educations do |map|
    map.permission :view_educations,   {:educations => [:index]},  :read => true
    map.permission :create_educations, {:educations => [:new, :create]},  :read => true
    map.permission :edit_educations,   {:educations => [:edit, :update]},  :read => true
    map.permission :delete_educations, {:educations => [ :destroy]},  :read => true
    map.permission :manage_educations, {:educations => [:new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :languages do |map|
    map.permission :view_languages, {:languages => [:index]},  :read => true
    map.permission :create_languages, {:languages => [:new, :create]},  :read => true
    map.permission :edit_languages, {:languages => [:edit, :update]},  :read => true
    map.permission :delete_languages, {:languages => [:destroy]},  :read => true
    map.permission :manage_languages, {:languages => [:new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :affiliations do |map|
    map.permission :view_affiliations, {:affiliations => [:index]},  :read => true
    map.permission :create_affiliations, {:affiliations => [:new, :create]},  :read => true
    map.permission :edit_affiliations, {:affiliations => [:edit, :update]},  :read => true
    map.permission :delete_affiliations, {:affiliations => [:destroy]},  :read => true
    map.permission :manage_affiliations, {:affiliations => [:new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :positions do |map|
    map.permission :view_positions, {:positions => [:index]},  :read => true
    map.permission :create_positions, {:positions => [:new, :create]},  :read => true
    map.permission :edit_positions, {:positions => [:edit, :update]},  :read => true
    map.permission :delete_positions, {:positions => [:destroy]},  :read => true
    map.permission :manage_positions, {:positions => [:new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :contacts do |map|
    map.permission :view_contacts, {:contacts => [:index]},  :read => true
    map.permission :create_contacts, {:contacts => [:new, :create]},  :read => true
    map.permission :edit_contacts, {:contacts => [:edit, :update]},  :read => true
    map.permission :delete_contacts, {:contacts => [:destroy]},  :read => true
    map.permission :manage_contacts, {:contacts => [:new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :certifications do |map|
    map.permission :view_certifications, {:certifications => [:index]},  :read => true
    map.permission :create_certifications, {:certifications => [:new, :create]},  :read => true
    map.permission :edit_certifications, {:certifications => [:edit, :update]},  :read => true
    map.permission :delete_certifications, {:certifications => [:destroy]},  :read => true
    map.permission :manage_certifications, {:certifications => [:new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :clearances do |map|
    map.permission :view_clearances, {:clearances => [:index]},  :read => true
    map.permission :create_clearances, {:clearances => [:new, :create]},  :read => true
    map.permission :edit_clearances, {:clearances => [:edit, :update]},  :read => true
    map.permission :delete_clearances, {:clearances => [:destroy]},  :read => true
    map.permission :manage_clearances, {:clearances => [:new, :create, :edit, :update, :destroy]},  :read => true
  end

   map.project_module :insurances do |map|
    map.permission :view_insurance, {:user_insurances => [:index]},  :read => true
    map.permission :create_insurance, {:user_insurances => [:new, :create]},  :read => true
    map.permission :edit_insurance, {:user_insurances => [:edit, :update]},  :read => true
    map.permission :delete_insurance, {:user_insurances => [:destroy]},  :read => true
    map.permission :manage_insurance, {:user_insurances => [:new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :other_skills do |map|
    map.permission :view_other_skills, {:other_skills => [:index]},  :read => true
    map.permission :create_other_skills, {:other_skills => [:new, :create]},  :read => true
    map.permission :edit_other_skills, {:other_skills => [:edit, :update]},  :read => true
    map.permission :delete_other_skills, {:other_skills => [:destroy]},  :read => true
    map.permission :manage_other_skills, {:other_skills => [:new, :create, :edit, :update, :destroy]},  :read => true
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
  
  
  # case user

  map.project_module :document do |map|
    map.permission :view_documents,   {:documents => [:index]},  :read => true
    map.permission :create_documents, {:documents => [:new, :create]},  :read => true
    map.permission :edit_documents,   {:documents => [ :edit, :update]},  :read => true
    map.permission :delete_documents, {:documents => [ :destroy]},  :read => true
    map.permission :manage_documents, {:documents => [:new, :create, :edit, :update, :destroy]},  :read => true
  end

   map.project_module :news do |map|
    map.permission :view_news, {:news => [:index]}, :read => true
    map.permission :create_news, {:news => [:new, :create]}, :read => true
    map.permission :edit_news, {:news => [:edit, :update]}, :read => true
    map.permission :delete_news, {:news => [:destroy]}, :read => true
    map.permission :manage_news, {:news => [:new, :create, :edit, :update, :destroy]}, :read => true
  end

   map.project_module :tasks do |map|
    map.permission :view_tasks, {:tasks => [:index]},  :read => true
    map.permission :create_tasks, {:tasks => [:new, :create]},  :read => true
    map.permission :edit_tasks, {:tasks => [:edit, :update]},  :read => true
    map.permission :delete_tasks, {:tasks => [:destroy]},  :read => true
    map.permission :manage_tasks, {:tasks => [:new, :create, :edit, :update, :destroy]},  :read => true
    map.permission :add_notes, {:tasks => [:add_note, :new_note]},  :read => true
    map.permission :view_notes, {:tasks => [:view_notes]},  :read => true
  end

  map.project_module :cases do |map|
    map.permission :view_cases, {:cases => [:index]},  :read => true
    map.permission :create_cases, {:cases => [:new, :create]},  :read => true
    map.permission :edit_cases, {:cases => [:edit, :update]},  :read => true
    map.permission :delete_cases, {:cases => [:destroy]},  :read => true
    map.permission :manage_cases, {:cases => [:watchers, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :appointments do |map|
    map.permission :view_appointments, {:appointments => [:index]},  :read => true
    map.permission :create_appointments, {:appointments => [:new, :create]},  :read => true
    map.permission :edit_appointments, {:appointments => [:edit, :update]},  :read => true
    map.permission :delete_appointments, {:appointments => [:destroy]},  :read => true
    map.permission :manage_appointments, {:appointments => [:new, :create, :edit, :update, :destroy]},  :read => true
  end

 map.project_module :surveys do |map|
    map.permission :view_surveys, {:surveys => [:index]},  :read => true
    map.permission :create_surveys, {:surveys => [:new, :create]},  :read => true
    map.permission :edit_surveys, {:surveys => [:edit, :update]},  :read => true
    map.permission :delete_surveys, {:surveys => [:destroy]},  :read => true
    map.permission :manage_surveys, {:surveys => [:new, :create, :edit, :update, :destroy]},  :read => true
  end
  
  map.project_module :wikis do |map|
    map.permission :manage_wikis, {:wikis => [:new, :create, :edit, :update, :history, :compare, :add_attachment, :destroy]},  :read => true
  end
  
 map.project_module :needs do |map|
    map.permission :view_needs, {:needs => [:index]},  :read => true
    map.permission :create_needs, {:needs => [:new, :create]},  :read => true
    map.permission :edit_needs, {:needs => [:edit, :update]},  :read => true
    map.permission :delete_needs, {:needs => [:destroy]},  :read => true
    map.permission :manage_needs, {:needs => [:new, :create, :edit, :update, :destroy]},  :read => true
  end
  
 map.project_module :goals do |map|
    map.permission :view_goals, {:goals => [:index]},  :read => true
    map.permission :create_goals, {:goals => [:new, :create]},  :read => true
    map.permission :edit_goals, {:goals => [:edit, :update]},  :read => true
    map.permission :delete_goals, {:goals => [:destroy]},  :read => true
    map.permission :manage_goals, {:goals => [:new, :create, :edit, :update, :destroy]},  :read => true
  end
  
 map.project_module :plans do |map|
    map.permission :view_plans, {:plans => [:index]},  :read => true
    map.permission :create_plans, {:plans => [:new, :create]},  :read => true
    map.permission :edit_plans, {:plans => [:edit, :update]},  :read => true
    map.permission :delete_plans, {:plans => [:destroy]},  :read => true
    map.permission :manage_plans, {:plans => [:new, :create, :edit, :update, :destroy]},  :read => true
  end
  
 # map.project_module :checklists do |map|
 #    map.permission :view_checklists, {:checklists => [:index]},  :read => true
 #    map.permission :create_checklists, {:checklists => [:new, :create]},  :read => true
 #    map.permission :edit_checklists, {:checklists => [:edit, :update]},  :read => true
 #    map.permission :delete_checklists, {:checklists => [:destroy]},  :read => true
 #    map.permission :manage_checklists, {:checklists => [:new, :create, :edit, :update, :destroy]},  :read => true
 # end

  map.project_module :employee do |map|
    map.permission :manage_roles, {
        :employees => [:index],
        :educations => [:index,:new, :create, :edit, :update, :destroy],
        :languages => [:index,:new, :create, :edit, :update, :destroy],
        :affiliations => [:index,:new, :create, :edit, :update, :destroy],
        :clearances => [:index,:new, :create, :edit, :update, :destroy],
        :user_insurances => [:index,:new, :create, :edit, :update, :destroy],
        :certifications => [:index,:new, :create, :edit, :update, :destroy],
        :contacts => [:index,:new, :create, :edit, :update, :destroy],
        :document => [:index,:new, :create, :edit, :update, :destroy],
        :positions => [:index,:new, :create, :edit, :update, :destroy],
        :surveys => [:index,:new, :create, :edit, :update, :destroy, :show],
        :tasks => [:index,:new, :create, :edit, :update, :destroy],
        :cases => [:watchers, :index,:new, :create, :edit, :update, :destroy],
        :appointments => [:index,:new, :create, :edit, :update, :destroy],
        :needs => [:index,:new, :create, :edit, :update, :destroy],
        :plans => [:index,:new, :create, :edit, :update, :destroy],
        :goals => [:index,:new, :create, :edit, :update, :destroy],
        :checklists => [:index,:new, :create, :edit, :update, :destroy],
        :wikis => [:new, :create, :edit, :update, :history, :compare, :add_attachment, :destroy]

    },  :read => true
  end

end