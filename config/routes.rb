Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:create]
    resources :sessions, only: [:create]
    resources :messages
    resources :conversations
  end
end
