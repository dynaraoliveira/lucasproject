Rails.application.routes.draw do
  
  get 'users/new'

  root 'sensors#index'
  
  resources :sensors
  
  namespace :api , defaults: {format: :json} do 
    namespace :v1 do 
      resources :sensors
    end 
  end
end
