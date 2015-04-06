Myflix::Application.routes.draw do
	root to: 'pages#front'
  get '/home', to: 'categories#index'
  get 'ui(/:action)', controller: 'ui'

  get 'register', to: 'users#new'
  get 'user', to: 'users#create'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'

  get 'my_queue', to: 'queue_items#index'
  get 'people', to: 'relationships#index'

  resources :relationships, only: [:create, :destroy]

  resources :videos do
    resources :reviews, only: [:create, :edit, :update]
    collection do
      get 'search', to: 'videos#search'
    end
  end
  resources :categories
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:create, :destroy]

  post 'update_queue', to: 'queue_items#update_queue' do
  end
end