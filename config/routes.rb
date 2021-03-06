Rails.application.routes.draw do

  get 'timeline/index'

  resources :formulars do
    resources :form_details, except: [:index]
  end
  resources :email_templates, except: [:show] do
    collection do
      get 'load_available_variables'
    end
  end
  resources :job_apps do
    resources :jobs
  end
  get 'exception_notifier/show'

  get 'sms/show', :as=> :show_sms
  post 'sms/send_sms', :as=> :send_sms

  resources :transports
  resources :measurement_records
  resources :measurements
  get '/histories/:type/:id', to: 'histories#show'
  resources :military_histories
  get 'occupation', to: 'idcdata#occupation'
  resources :resumes
  resources :related_clients
  resources :case_organizations
  resources :radiologic_examinations
  resources :laboratory_examinations
  resources :billings, except: [:new]
  resources :appointments do
    get 'calendar', on: :collection
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
  resources :jsignatures do
    member do
      get 'image'
    end
  end
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
      post 'new_folder'
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
  resources :case_watchers, except: [:new, :create]
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
  resources :job_app_notes, except: [:index], controller: :notes
  resources :client_journal_notes, except: [:index], controller: :notes
  resources :transport_notes, except: [:index], controller: :notes
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
      match 'timeline', via: [:post, :get]
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
  resources :client_documents


  resources :surveys do
    member do
      post   'answer'
      get    'new_note'
      get    'edit_answer'
      post   'edit_answer'
      delete 'delete_answer'
      get 'copy'
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
      get 'copy'
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
      match 'active', via: [:post, :get]
      match 'audit', via: [ :get]
    end
    member do
      get 'require_change_password'
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


  namespace :extend_demographies do
    scope ':extend_demography_id' do
      resources :emails, except: [:index]
      resources :faxes, except: [:index]
      resources :phones, except: [:index]
      resources :identifications
      resources :social_media, except: [:index]
      resources :addresses, except: [:index]
    end
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
      post 'set_notification'
      post 'set_modules'
      post 'set_theme'
      post 'set_key_providers'
    end
  end

  resources :overdues, only: :index do
    collection do
      get 'case_overdue'
      get 'appointment_overdue'
      get 'need_overdue'
      get 'plan_overdue'
      get 'goal_overdue'
      get 'action_overdue'
    end
  end

  # Engines
  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    resources :exception_notifier, only: [:index, :show]
    mount Sidekiq::Web => '/sidekiq'
  end

  mount Thredded::Engine => '/forum'
  mount MeasurementsConverter::Engine => '/measurements_converter'
  mount Calculator::Engine => '/calculator'
  mount TodoList::Engine => "/todo_list"
  mount StickyNotes::Engine => "/sticky_notes"
  mount Rordit::Engine => "/rordit"
  mount Kanban::Engine => "/kanban"
  mount EventCalendar::Engine => "/event_calendar"
  mount Links::Engine => "/links"
  mount Inventory::Engine => "/inventory"
  mount Lms::Engine => "/lms"
  mount Mindmap::Engine => "/mindmap"
  mount RssFeed::Engine => "/rss"
  mount TextEditor::Engine => "/texteditor"
  mount SvgEdit::Engine => "/svg_edit"
  mount Mhspreadsheet::Engine => "/mhspreadsheet"
  # mount CommunityEngine::Engine => "/community_engine"
end
