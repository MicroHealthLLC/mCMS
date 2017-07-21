Mindmap::Engine.routes.draw do
  get 'mindmap/index'
  get 'mindmap/save'
  root to: "mindmap#index"
end
