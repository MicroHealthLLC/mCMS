Calculator::Engine.routes.draw do
  get 'calculator/index'
  root to: 'calculator#index'


end
