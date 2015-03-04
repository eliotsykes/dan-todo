Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show]

  resources :lists do
    resources :items, only: [:create, :destroy]
  end

  root to: 'welcome#index'
end
