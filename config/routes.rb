Rails.application.routes.draw do

  root 'static_pages#arazin'
  get '/magicdeal',to:'static_pages#magicdeal'
  get '/ranking',to:'static_pages#ranking'
  get '/card',to:'static_pages#card'
  get '/help',to:'static_pages#help'
  get '/ec',to:'static_pages#ec'  # 出店(暫定)
  
  get '/signup',to: 'users#new'
  post '/signup',  to: 'users#create'
  
  # UsersリソースをRESTfulにする
  resources :users  
  
  
  # 他のポートフォリオ
  get '/cafe',to:'static_pages#cafe'
  get '/javascript',to: 'static_pages#javascript'
  get '/gallery',to: 'static_pages#gallery'
end
