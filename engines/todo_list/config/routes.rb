TodoList::Engine.routes.draw do
  resources :todos, only: [:index] do
    get 'save', on: :collection
  end
  root to: "todos#index"
end
