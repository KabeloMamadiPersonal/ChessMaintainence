Rails.application.routes.draw do

  root 'members#index'

  resources :members

  get '/members/view_all', to: 'members#view_all'
  post '/members/update', to: 'members#update'
  get '/log_match', to: 'members#log_match'
  post '/log_match', to: 'members#log_match'

end
