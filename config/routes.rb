Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show]

  resources :lists do
    resources :items, only: [:create, :destroy]
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
