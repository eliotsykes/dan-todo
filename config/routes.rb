Rails.application.routes.draw do
  resources :lists

  devise_for :users
  resources :users, only: [:show] do
    resources :items, only: [:create]
  end

  root to: 'welcome#index'
end
