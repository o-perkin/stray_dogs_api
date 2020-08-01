Rails.application.routes.draw do

  root to: "dogs#home"
  get 'dogs/new', to: 'dogs#new'  
  get 'dogs/:id/edit', to: 'dogs#edit'  
  resources :dogs
  resources :favorites, only: [:destroy]
  resources :subscribes
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  get 'favorites/update', defaults: { format: 'js' }
  get '/my_list', to: 'dogs#my_list'  
  get 'my_favorites', to: 'dogs#favorites'  

end
