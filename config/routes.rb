Rails.application.routes.draw do
  resources :plans
  resources :goals
  resources :needs
  resources :user_insurances
  resources :insurances do
    resources :insurance_extend_demographies, only: [:create, :update], controller: :extend_demographies
  end
  resources :appointments
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
  resources :notes

  resources :cases do
    collection do
      get 'subcases'
    end
    member do
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
    end
  end
  resources :documents


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


  # Routes For Admin
  resources :checklist_templates, controller: :checklists do
    member do
      match 'save', via: [:patch, :put, :post]
      get 'new_note'
    end
    collection do
      get 'new_assign'
      post 'new_assign'
    end
  end
  resources :users, only: [:index, :show, :destroy] do
    collection do
      match 'recently_connected', via: [:post, :get]
    end
    member do
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

  resources :enumerations
  resources :roles
  resources :settings, only: [:index, :create] do
    collection do
      post 'set_modules'
      post 'set_theme'
    end
  end
end
