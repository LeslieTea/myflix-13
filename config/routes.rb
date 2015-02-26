Myflix::Application.routes.draw do
  root to: 'pages#front'
  
  
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  post 'sign_out', to: 'sessions#destroy'
  get 'home', to: 'categories#index'
  get 'ui(/:action)', controller: 'ui'
  get '/videos/:id', to: 'videos#show', as: 'video'
  
  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
  end
  end
  
  resources :categories, only:[:show] do
  end
  
  resources :users, only:[:create] do
  end
  
  resources :sessions, only:[:create, :new, :destroy] do
  end
  
  resources :pages do
  end
end