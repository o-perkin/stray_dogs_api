Rails.application.routes.draw do
  
  get 'favorites/update'
  get 'my_favorites', to: 'dogs#favorites'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :dogs
  get '/dogs', to: 'dogs#index'
  root to: "dogs#home"

  
end
