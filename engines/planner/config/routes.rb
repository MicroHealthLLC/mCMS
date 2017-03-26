Planner::Engine.routes.draw do
  get 'kanban/index'
  root to: 'kanban#index'
end
