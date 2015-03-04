Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show] do
    resources :lists do
      resources :items, only: [:create, :destroy]
    end
  end

  root to: 'welcome#index'
end
