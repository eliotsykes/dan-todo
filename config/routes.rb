Rails.application.routes.draw do
  
  # get "/login", to: static("index.html")
  # get "/register", to: static("index.html"), as: :new_user_registration
  
  devise_for :users, only: [:sessions, :passwords, :confirmations] # removed: :registrations
  resources :users, only: [:show]

  resources :lists do
    resources :items, only: [:create, :destroy]
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create], format: false, defaults: { format: :json }
    end
  end

  namespace :api do
    namespace :v1 do
      resources :lists, except: [:show] do
        resources :items, only: [:create, :destroy]
      end
    end
  end

  root to: 'welcome#index'
end
