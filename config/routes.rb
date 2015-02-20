Myflix::Application.routes.draw do
  root to: 'categories#index'
  
  
  get 'home', to: 'categories#index'
  get 'ui(/:action)', controller: 'ui'
  get '/videos/:id', to: 'videos#show', as: 'video'
  
  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
  end
    
    member do
      post 'highlight', to: 'videos#highlight'
    end
  end
  
  resources :categories, only:[:show] do
  end
end
