Mameblog::Application.routes.draw do

  resources :brothers do
    member do
      get :following, :followers
    end
  end

  resources :brothers
  resources :sessions, only: [:create, :destroy]
  resources :entries, only: [:create, :destroy, :show, :update, :edit]
  resources :relationships, only: [:create, :destroy]
  resources :circuses

  root 'static_pages#home'

  get '/signup',  to: 'brothers#new'
  get '/signin',  to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
  get "/contributors", to: 'contributors#index'
  get "votes", to: 'votes#index'
end
