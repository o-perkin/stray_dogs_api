Rails.application.routes.draw do

  namespace :api do 
    namespace :v1 do 
      root to: "dogs#home"
      resources :dogs      
      resources :subscribes
      get 'favorites/update', defaults: { format: 'js' }
      get '/my_list', to: 'dogs#my_list'  
      get 'my_favorites', to: 'dogs#favorites' 

      
      
    end
  end   
 
      devise_for :users,
                   path: '',
                   path_names: {
                     sign_in: 'login',
                     sign_out: 'logout'
                  },
                   controllers: {
                     sessions: 'sessions',
                     registrations: 'registrations'
                   }
  
end
