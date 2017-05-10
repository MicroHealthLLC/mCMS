Inventory::Engine.routes.draw do
  resources :products
  resources :product_assigns
  root to: "products#index"
end
