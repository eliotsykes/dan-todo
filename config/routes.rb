Rails.application.routes.draw do
  resources :lists

  devise_for :users
  resources :users, only: [:show]

  root to: 'welcome#index'
end
