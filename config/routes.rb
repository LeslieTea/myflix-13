Myflix::Application.routes.draw do
  root to: 'videos#index'
  
  
  get 'home', to: 'videos#index'
  get 'ui(/:action)', controller: 'ui'
  get '/videos/:id', to: 'videos#show', as: 'video'
  
  resources :videos, only: [:show] do
  end
  
end
