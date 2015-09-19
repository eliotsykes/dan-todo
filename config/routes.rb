Rails.application.routes.draw do

  devise_for :users,
    only: [:passwords, :confirmations], # removed: :registrations, :sessions
    controllers: { confirmations: :confirmations }

  resources :users, only: [:show]

  resources :lists do
    resources :items, only: [:create, :destroy]
  end

  namespace :api do
    namespace :v1 do
      resources :sessions, only: :create, format: false
      resources :users, only: :create, format: false, defaults: { format: :json }
      resources :lists, only: [:index, :create, :update, :destroy] do
        resources :items, only: [:create, :destroy]
      end
    end
  end

  root to: 'welcome#index'
  get '/' => 'welcome#index', as: :login, defaults: { anchor: "/login" }
end
