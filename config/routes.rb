Rails.application.routes.draw do

  # static
  root 'static_pages#arazin'
  
  get '/magicdeal',to:'static_pages#magicdeal'
  get '/ranking',to:'static_pages#ranking'
  get '/help',to:'static_pages#help'
  get '/ec',to:'static_pages#ec'  # 出店(暫定)
  
  get '/histories',to:'static_pages#histories'
  get '/clips',to:'static_pages#clips'
  get '/boughts',to:'static_pages#boughts'
  
  
  # users
  get '/signup',to: 'users#new'
  post '/signup',  to: 'users#create'
  
  # sessions
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :relationships,       only: [:create, :destroy]
  
  resources :items do
    member do
      post "add_clip", to: "clips#create"
    end
  end
  
  resources :clips, only: [:destroy]
  
  # カート
  resources :carts, only: [:show]
  
  post '/add_item', to:'carts#add_item'
  post '/update_item', to: 'carts#update_item'
  delete '/delete_item', to: 'carts#delete_item'
  
  post '/cart_login', to:'carts#cart_login'
  get '/cart_login', to:'carts#cart_login'
  
  # get '/cart_login',to:'carts#cart_login'
  post '/cart_login_create', to:'carts#cart_login_create'
  
  get '/pay_view',to:'carts#pay_view'
  post '/pay_view', to:'carts#pay'
  
  # resources :cards
  get '/card_create',to: 'cards#new'
  post '/card_create',to: 'cards#create'

  get '/pay_confirmation',to:'carts#pay_confirmation'

  # 他のポートフォリオ
  get '/cafe',to:'static_pages#cafe'
  get '/javascript',to: 'static_pages#javascript'
  get '/gallery',to: 'static_pages#gallery'
end