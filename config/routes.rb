Myflix::Application.routes.draw do
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
  resources :forgot_passwords, only: [:create]
  get "forgot_password_confirmation", to: 'forgot_passwords#confirm'

end