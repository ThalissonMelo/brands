Rails.application.routes.draw do
  resources :users
  resources :brands do
    resources :products
  end

  post "users/:id/follow", to: "users#add_follow_brands"
  get "users/:id/brands", to: "users#show_follow_brands"
  delete "users/:id/follow", to: "users#unfollow_brand"

  post "users/:id/invite", to: "users#friendship_invitations"
  get "users/:id/invites", to: "users#show_invite_list"

  post "users/:id/accept_friendship", to: "users#accept_friendship"
  get "users/:id/friends", to: "users#show_user_friends"
end
