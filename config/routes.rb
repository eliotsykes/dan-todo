Rails.application.routes.draw do
  resources :lists

  devise_for :users
  root to: 'welcome#index'
end
