Rails.application.routes.draw do
  
  devise_for :users
  resources :dogs
  root to: "home#index"
  
end
