Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:create]
    resources :sessions, only: [:create]
    resources :conversations do
      resources :messages
    end
  end
end
