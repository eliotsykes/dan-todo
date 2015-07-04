Rails.application.routes.draw do

  # def static_index_route(name)
    # get "/#{name}", as: name, to: static("index.html"), defaults: { anchor: "/#{name}" }
  # end

  # get '/register', as: :register, to: static("index.html"), defaults: { anchor: "/register" }
  # get '/login', as: :login, to: static("index.html"), defaults: { anchor: "/login" }
  # static_index_route :register
  # static_index_route :login

  devise_for :users,
    only: [:passwords, :confirmations], # removed: :registrations, :sessions
    controllers: { confirmations: :confirmations }
  
  resources :users, only: [:show]

  resources :lists do
    resources :items, only: [:create, :destroy]
  end

  namespace :api do
    namespace :v1 do
      resources :sessions, only: :create, format: false, defaults: { format: :json }
      resources :users, only: :create, format: false, defaults: { format: :json }
      resources :lists, except: [:show] do
        resources :items, only: [:create, :destroy]
      end
    end
  end

  root to: 'welcome#index'
  get '/' => 'welcome#index', as: :login, defaults: { anchor: "/login" }
end
