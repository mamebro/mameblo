Mameblog::Application.routes.draw do

  get "jinja/index"
  resources :brothers, except: [:destroy] do
    member do
      get :following, :followers
    end
  end

  resources :sessions, only: [:create, :destroy]
  resources :entries, only: [:create, :destroy, :show, :update, :edit] do
    resources :beans, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :circuses, only: [:index]
  resources :votes, only: [:index]

  root 'static_pages#home'

  get '/signup',  to: 'brothers#new'
  get '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
  get "/contributors", to: 'contributors#index'
  get "/jinja/omikuji", to: 'jinja/omikuji#index'
  get "/jinja", to: 'jinja#index'
end
