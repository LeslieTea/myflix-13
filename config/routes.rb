Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'home', to: 'categories#index'
  
  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
    resources :reviews, only:[:create]
  end
  
  resources :categories, only:[:show]
  resources :queue_items, only: [:create, :destroy]

  
  get 'my_queue', to: 'queue_items#index'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  post 'sign_out', to: 'sessions#destroy'
  get 'ui(/:action)', controller: 'ui'
 
  
  resources :users, only:[:create] do
  end
  resources :sessions, only:[:create, :new, :destroy] do
  end

end