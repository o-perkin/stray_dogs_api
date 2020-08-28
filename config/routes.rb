Rails.application.routes.draw do

  namespace :api do 
    namespace :v1 do 
      resources :dogs      
      resources :subscribes
      get 'new_dog', to: 'dogs#new'
      get '/dogs/edit/:id', to: 'dogs#edit'
      get 'my_dogs', to: 'dogs#my_dogs'  
      get 'favorite_dogs', to: 'dogs#favorite_dogs'  
      get 'favorites/update', defaults: { format: 'js' }
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
