Rails.application.routes.draw do

  root to: "home#index"

  get "auth/:provider/callback", to: "sessions#create"

  resources :sessions

end
