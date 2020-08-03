Rails.application.routes.draw do

  root to: "dogs#home"

  resources :dogs
  devise_for :users,
           path: '',
           path_names: {
             sign_in: 'login',
             sign_out: 'logout',
             sign_up: 'register'
           },
           controllers: {
             sessions: 'sessions',
             registrations: 'registrations'
           }
  resources :favorites, only: [:destroy]
  resources :subscribes
  get 'favorites/update', defaults: { format: 'js' }
  get '/my_list', to: 'dogs#my_list'  
  get 'my_favorites', to: 'dogs#favorites'       
  
end
