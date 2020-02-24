Rails.application.routes.draw do

  # static
  root 'static_pages#arazin'
  
  get '/magicdeal',to:'static_pages#magicdeal'
  get '/ranking',to:'static_pages#ranking'
  get '/card',to:'static_pages#card'
  get '/help',to:'static_pages#help'
  get '/ec',to:'static_pages#ec'  # 出店(暫定)
  
  # users
  get '/signup',to: 'users#new'
  post '/signup',  to: 'users#create'
  
  # sessions
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :users
  resources :items
  
  
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

  # 他のポートフォリオ
  get '/cafe',to:'static_pages#cafe'
  get '/javascript',to: 'static_pages#javascript'
  get '/gallery',to: 'static_pages#gallery'
end