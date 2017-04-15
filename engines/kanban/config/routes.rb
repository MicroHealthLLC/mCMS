Kanban::Engine.routes.draw do
  get 'cards/index'

  post 'cards/create'

  put 'cards/update'

  post 'cards/archive'

  post 'cards/unarchive'

  delete 'cards/destroy'

  get 'columns/index'

  post 'columns/create'

  put 'columns/update'

  delete 'columns/destroy'

  get 'projects/index'

  post 'projects/create'

  post 'projects/update'

  delete 'projects/destroy'

  post 'projects/index'
  get 'projects/index'
  # get 'projects/:project_id'

  root to: 'projects#index'
end
