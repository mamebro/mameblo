Mameblog::Application.routes.draw do

  resources :password_resets, only: [:new, :create, :update, :edit]

  get "jinja/index"
  resources :brothers, except: [:destroy] do
    member do
      get :following, :followers
    end
  end

  resource :settings, except: [:destroy] do
    member do
      get :index
      get :email
      post :deliver_alter_email
      patch :cancel_alter_email
    end
  end
  get '/verify_email/:id', to: 'settings#verify_email'

  resources :sessions, only: [:create, :destroy]
  resources :entries, only: [:create, :destroy, :show, :update, :edit] do
    resources :beans, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :circuses, only: [:index]
  resources :votes, only: [:index]

  root 'timelines#index'

  get '/timelines/brothers', to: 'timelines#brothers'
  get '/signup',  to: 'brothers#new'
  get '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
  get "/contributors", to: 'contributors#index'
  get "/jinja/omikuji", to: 'jinja/omikuji#index'
  get "/jinja", to: 'jinja#index'
  get "/jinja/osaisen", to: 'jinja/osaisen#index'

  namespace :api do
    post '/signin', to: 'sessions#create'
    delete '/signout', to: 'sessions#destroy'
    resources :entries, only: [:show] do
      collection do
        get :home
      end
    end
  end

  get 'tent/home', to: 'tent/home#index'
end
