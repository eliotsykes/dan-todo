Rails.application.routes.draw do
  resources :lists, except: [:index]

  devise_for :users
  root to: 'welcome#index'
end
