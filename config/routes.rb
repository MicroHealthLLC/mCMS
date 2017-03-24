Rails.application.routes.draw do
  get 'occupation', to: 'idcdata#occupation'
  resources :resumes
  resources :related_clients
  resources :radiologic_examinations
  resources :laboratory_examinations
  resources :billings, except: [:new]
  resources :appointments do
    get 'cms_form', on: :member
    resources :billings, only: [:new]
  end
  resources :appointment_procedures
  resources :appointment_dispositions
  resources :appointment_captures, except: [:index]

  get 'profile_record',  to: 'user_profiles#profile_record'
  get 'occupational_record',  to: 'user_profiles#occupational_record'
  get 'medical_record', to: 'user_history#medical_record'
  get 'socioeconomic_record', to: 'user_history#socioeconomic_record'


  post 'add_appointment_link', to: 'user_cases#add_appointment_link'
  get 'unlink_appointment', to: 'user_cases#unlink_appointment'
  post 'set_appointment_store', to: 'user_cases#set_appointment_store_id'

  resources :referrals do
    resources :referral_results, except: [:index]
    collection do
      get 'find_organization'
    end
    member do
      get 'links'
      get 'add_referral'
    end
  end
  resources :jsignatures
  resources :job_applications
  resources :worker_compensations
  resources :injuries
  get 'immunization_cvx/index'

  resources :hcpc, only: [:index]

  get 'medication_fetch', to: 'idcdata#medication'
  get 'snomed', to: 'idcdata#search_snomed'

  resources :idcdata, only: [:index]
  resources :behavioral_risks
  resources :other_histories
  resources :environment_risks
  resources :socioeconomics
  resources :immunizations
  resources :family_histories
  resources :medicals
  resources :surgicals
  resources :allergies
  resources :medications
  resources :problem_lists
  resources :sticky, only: [:index] do
    collection do
      get 'save'
    end
  end

  resources :legals
  resources :financials
  resources :transportations
  resources :mtf_hospitals
  resources :incident_histories
  resources :deployment_histories
  resources :units
  resources :awards
  resources :service_histories
  resources :housings
  resources :health_care_facilities
  resources :admissions
  resources :daily_livings
  resources :teleconsults
  resources :enrollments
  resources :client_journals

  resources :groups do
    member do
      post :add_member
      post :remove_member
    end
    resources :memberships, only: [:new, :create, :update, :destroy] do
      member do
        get :promote
        get :demote
      end
    end
  end

  resources :document_managers  do
    member do
      get :download
    end
    collection do
      get :search
      post :search
    end

    resources :revisions, only: [:create, :destroy] do
      member do
        get :download
      end
    end
  end

  resources :categories do
    member do
      get :subcategories
    end
    collection do
      get :manage
    end
  end


  resources :checklist_cases, only: [:index, :destroy, :show, :update]
  resources :note_templates
  resources :case_supports do
    member do
      get 'remove'
    end
    collection do
      match 'search', via: [:get, :post]
    end
    resources :case_support_extend_demographies, only: [:create, :update], controller: :extend_demographies
  end
  resources :case_watchers, only: [:index]
  resources :plans do
    match 'links', via: [:get, :post], on: :member
    match 'add_action', via: [:get], on: :member

    match 'link_goal', via: [:get, :post], on: :member
    match 'add_goal', via: [:get], on: :member

  end
  resources :goals do
    match 'links', via: [:get, :post], on: :member
    match 'add_plan', via: [:get], on: :member

    match 'link_need', via: [:get, :post], on: :member
    match 'add_need', via: [:get], on: :member
  end
  resources :needs do
    match 'links', via: [:get], on: :member
    match 'add_goal', via: [:get], on: :member
  end
  resources :user_insurances
  resources :insurances do
    resources :insurance_extend_demographies, only: [:create, :update], controller: :extend_demographies
  end
  resources :news
  match '/wiki_pages/new_page_title', via: [:get, :post]
  wiki_root '/wiki'
  mount Thredded::Engine => '/forum'
  resources :checklist_notes, except: [:index], controller: :notes
  resources :survey_notes, except: [:index], controller: :notes
  resources :case_notes, except: [:index], controller: :notes
  resources :task_notes, except: [:index], controller: :notes
  resources :post_notes, except: [:index], controller: :notes
  resources :plan_notes, except: [:index], controller: :notes
  resources :goal_notes, except: [:index], controller: :notes
  resources :need_notes, except: [:index], controller: :notes
  resources :appointment_notes, except: [:index], controller: :notes
  resources :document_notes, except: [:index], controller: :notes
  resources :referral_notes, except: [:index], controller: :notes
  resources :client_journal_notes, except: [:index], controller: :notes
  resources :attempt_notes, controller: :notes
  resources :notes do
    collection do
      get 'get_template_note'
    end
  end

  resources :cases do
    collection do
      get 'subcases'
      get 'all_files'
    end
    member do
      match 'watchers', via: [:post, :get]
      get 'delete_sub_case_relation'
      get 'delete_relation'
      match 'new_relation', via: [:post, :get]
      match 'new_assign', via: [:post, :get]
      match 'new_assign_survey', via: [:post, :get]
    end
  end
  resources :attempts, :only => [:new, :create, :index]
  get 'pivot_table/index'

  get 'settings/edit'
  get 'home/index'
  get 'home/chat'
  mount ActionCable.server => '/cable'
  get 'conference/new_conference', to: 'chat_rooms#conference'
  get 'conference/:appear_id', to: 'chat_rooms#conference'
  resources :chat_rooms, param: :token, only: [:show] do
    collection do
      get 'create_or_find'
    end
  end

  root to: "home#index"
  get 'home/all_informations', as: 'all_informations'

  get 'home/pivottable'

  devise_for :users, :controllers => { omniauth_callbacks: 'callbacks' }

  # Routes For Normal users
  resources :core_demographics, only: [:show]
  resources :departments do
    resources :department_extend_demographies, only: [:create, :update], controller: :extend_demographies
  end
  resources :contacts do
    member do
      get 'remove'
    end
    collection do
      match 'search', via: [:get, :post]
    end

    resources :contact_extend_demographies, only: [:create, :update], controller: :extend_demographies
  end
  resources :affiliations do
    resources :affiliation_extend_demographies,  only: [:create, :update], controller: :extend_demographies
  end
  resources :organizations do
    resources :organization_extend_demographies, only: [:create, :update], controller: :extend_demographies
  end

  resources :other_skills
  resources :clearances
  resources :certifications
  resources :educations
  resources :languages
  resources :positions
  resources :tasks do
    member do
      post 'new_note'
      get 'add_note'
      get 'delete_sub_task_relation'

      match 'link_plan', via: [:get, :post]
      match 'add_plan', via: [:get]

    end
  end
  get 'all_files', to: "documents#all_files"
  resources :documents
  resources :client_documents, only: [:index, :new, :show, :edit]


  resources :surveys do
    member do
      post   'answer'
      get    'new_note'
      get    'edit_answer'
      post   'edit_answer'
      delete 'delete_answer'
    end

    collection do
      get 'new_assign'
      post 'new_assign'
    end
  end
  resources :survey_survey,  controller: :surveys
  resources :survey_attempt,  controller: :attempts


  # Routes For Admin
  resources :checklist_templates, controller: :checklists do
    member do
      match 'save', via: [:patch, :put, :post]
    end
    collection do
      get 'display'
      get 'new_assign'
      post 'new_assign'
    end
  end
  resources :users, only: [:index, :show, :destroy] do
    collection do
      match 'recently_connected', via: [:post, :get]
    end
    member do
      get 'restore'
      get 'lock'
      get 'unlock'
      put 'change_password'
      put 'change_basic_info'
      put 'attachments'
      post 'image_upload'
      get 'remove_image'
    end

    resources :core_demographics, only: [:create, :update]
    resources :job_details, only: [:create, :update]
    resources :user_extend_demographies, only: [:create, :update], controller: :extend_demographies
  end

  resources :employees, path: :persons, except: [:edit] do
    member do
      get 'log_in'
    end
    get 'home/index', as: 'home'
  end

  resources :enumerations do
    collection do
      post 'upload'
    end
  end
  resources :roles
  resources :settings, only: [:index, :create] do
    collection do
      post 'set_user_auth'
      post 'set_modules'
      post 'set_theme'
    end
  end
end
