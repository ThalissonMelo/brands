Rails.application.routes.draw do
  resources :users
  resources :products
  resources :brands
  post "users/:id/follow", to: "users#add_follow_brands"
  get "users/:id/brands", to: "users#show_follow_brands"
  delete "users/:id/follow", to: "users#unfollow_brand"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
