RedCarpet::AccessControl.map do |map|

  # user profile & occupation History
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

  map.project_module :resumes do |map|
    map.permission :view_resumes, {:resumes => [:index]},  :read => true
    map.permission :show_resumes, {:resumes => [:show]},  :read => true
    map.permission :create_resumes, {:resumes => [:new, :create]},  :read => true
    map.permission :edit_resumes, {:resumes => [:edit, :update]},  :read => true
    map.permission :delete_resumes, {:resumes => [:destroy]},  :read => true
    map.permission :manage_resumes, {:resumes => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :job_applications do |map|
    map.permission :view_job_applications, {:job_apps => [:index]},  :read => true
    map.permission :show_job_applications, {:job_apps => [:show], :jobs => [:index, :show]},  :read => true
    map.permission :create_job_applications, {:job_apps => [:new, :create], :jobs => [:new, :create]},  :read => true
    map.permission :edit_job_applications, {:job_apps => [:edit, :update], :jobs => [:edit, :update]},  :read => true
    map.permission :delete_job_applications, {:job_apps => [:destroy], :jobs => [:destroy]},  :read => true
    map.permission :manage_job_applications, {:job_apps => [:index, :show, :new, :create, :edit, :update, :destroy], :jobs => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :injuries do |map|
    map.permission :view_injuries, {:injuries => [:index]},  :read => true
    map.permission :show_injuries, {:injuries => [:show]},  :read => true
    map.permission :create_injuries, {:injuries => [:new, :create]},  :read => true
    map.permission :edit_injuries, {:injuries => [:edit, :update]},  :read => true
    map.permission :delete_injuries, {:injuries => [:destroy]},  :read => true
    map.permission :manage_injuries, {:injuries => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :jsignatures do |map|
    map.permission :view_jsignatures, {:jsignatures => [:index, :show]},  :read => true
    map.permission :create_jsignatures, {:jsignatures => [:new, :create]},  :read => true
    map.permission :edit_jsignatures, {:jsignatures => [:edit, :update]},  :read => true
    map.permission :delete_jsignatures, {:jsignatures => [:destroy]},  :read => true
    map.permission :manage_jsignatures, {:jsignatures => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :worker_compensations do |map|
    map.permission :view_worker_compensations, {:worker_compensations => [:index]},  :read => true
    map.permission :show_worker_compensations, {:worker_compensations => [:show]},  :read => true
    map.permission :create_worker_compensations, {:worker_compensations => [:new, :create]},  :read => true
    map.permission :edit_worker_compensations, {:worker_compensations => [:edit, :update]},  :read => true
    map.permission :delete_worker_compensations, {:worker_compensations => [:destroy]},  :read => true
    map.permission :manage_worker_compensations, {:worker_compensations => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :affiliations do |map|
    map.permission :view_affiliations, {:affiliations => [:index]},  :read => true
    map.permission :show_affiliations, {:affiliations => [:show]},  :read => true
    map.permission :create_affiliations, {:affiliations => [:new, :create]},  :read => true
    map.permission :edit_affiliations, {:affiliations => [:edit, :update]},  :read => true
    map.permission :delete_affiliations, {:affiliations => [:destroy]},  :read => true
    map.permission :manage_affiliations, {:affiliations => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :military_histories do |map|
    map.permission :view_military_histories, {:military_histories => [:index]},  :read => true
    map.permission :show_military_histories, {:military_histories => [:show]},  :read => true
    map.permission :create_military_histories, {:military_histories => [:new, :create]},  :read => true
    map.permission :edit_military_histories, {:military_histories => [:edit, :update]},  :read => true
    map.permission :delete_military_histories, {:military_histories => [:destroy]},  :read => true
    map.permission :manage_military_histories, {:military_histories => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
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
    map.permission :view_insurances, {:user_insurances => [:index]},  :read => true
    map.permission :show_insurances, {:user_insurances => [:show]},  :read => true
    map.permission :create_insurances, {:user_insurances => [:new, :create]},  :read => true
    map.permission :edit_insurances, {:user_insurances => [:edit, :update]},  :read => true
    map.permission :delete_insurances, {:user_insurances => [:destroy]},  :read => true
    map.permission :manage_insurances, {:user_insurances => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

  map.project_module :other_skills do |map|
    map.permission :view_other_skills, {:other_skills => [:index]},  :read => true
    map.permission :show_other_skills, {:other_skills => [:show]},  :read => true
    map.permission :create_other_skills, {:other_skills => [:new, :create]},  :read => true
    map.permission :edit_other_skills, {:other_skills => [:edit, :update]},  :read => true
    map.permission :delete_other_skills, {:other_skills => [:destroy]},  :read => true
    map.permission :manage_other_skills, {:other_skills => [:index, :show, :new, :create, :edit, :update, :destroy]},  :read => true
  end

 map.project_module :sms do |map|
    map.permission :send_sms, {:sms => [:show, :send_sms]},  :read => true
  end

end
