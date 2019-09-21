Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:create] do
      collection do 
        get :search
      end
    end
    resources :sessions, only: [:create]
    resources :conversations do
      resources :messages
    end
    mount ActionCable.server => '/cable'
  end
end
