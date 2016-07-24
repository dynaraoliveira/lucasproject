Rails.application.routes.draw do
  
  get 'users/new'
  
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  root 'sensors#index'
  
  resources :sensors
  
  namespace :api , defaults: {format: :json} do 
    namespace :v1 do 
      resources :sensors
    end 
  end
end
