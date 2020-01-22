Rails.application.routes.draw do

  # static
  root 'static_pages#arazin'
  # root 'items#index'
  # root '/',to:'items#index'
  # get '/items',to:'items#index'
  # delete '/items',to:'items#destroy'
  
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
  
  # get '/items',to:'items#index'
  # UsersリソースをRESTfulにする
  # Userリソースとuserのidの下にitemリソースを作成する　/user/1/item/
  # resources :users do
    # member do
      # resource :items,except: [:index,:delete]
      # get :itemindex,:itemshow,:itemnew,:itemdestroy,:itemupdate
      # post :itemcreate
    # end
  # end
 
  
  # 他のポートフォリオ
  get '/cafe',to:'static_pages#cafe'
  get '/javascript',to: 'static_pages#javascript'
  get '/gallery',to: 'static_pages#gallery'
end
