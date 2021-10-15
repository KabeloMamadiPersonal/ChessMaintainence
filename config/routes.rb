Rails.application.routes.draw do

  devise_for :users
  # resources :users

  # root '/users/sign_up'
  # GET "/users/sign_up"
  # root '/devise/sessions#create'
  root 'members#index'

  resources :members

  get '/members/view_all', to: 'members#view_all'
  post '/members/update', to: 'members#update'
  get '/log_match', to: 'members#log_match'
  post '/log_match', to: 'members#log_match'

end
