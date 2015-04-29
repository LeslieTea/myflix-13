Myflix::Application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get 'ui(/:action)', controller: 'ui'

  root 'pages#front'
  
  get 'home', to: 'categories#index'

  resources :videos, only: [:show] do 
    resources :reviews, only: [:create]
    collection do
      get 'search', to: 'videos#search'
    end
  end

  resources :categories, only: [:show]

  get 'register', to: "users#new"
  resources :users, only: [:show, :create]

  get 'people', to: 'relationships#index'
  resources :relationships, only: [:destroy, :create]

  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'
  resources :queue_items, only: [:create, :destroy, :update]

  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  resources :sessions, only: [:create, :new, :destroy]
  
  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :forgot_passwords, only: [:create]

  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'
  get 'password_reset', to: 'password_resets#show'

  resources :invitations, only: [:new, :create]
   
end