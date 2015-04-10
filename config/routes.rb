Mameblog::Application.routes.draw do

  resources :hashtag, only: [:show]

  resources :password_resets, only: [:new, :create, :update, :edit]

  resources :brothers, except: [:destroy] do
    member do
      get :following, :followers
    end
  end
  get '/discover', to: 'brothers#discover'

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
  get "/jinja", to: 'jinja#index'
  get "/jinja/omikuji", to: 'jinja/omikuji#index'
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
