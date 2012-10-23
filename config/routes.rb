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
  resources :circus

  root to: 'static_pages#home'

  match '/signup',  to: 'brothers#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

end
