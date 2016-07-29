Rails.application.routes.draw do
  
  resources :equipaments
  resources :equipamentusers
  root 'sessions#new'
  
  get 'sessions/new'

  get 'users/new'
  
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :sensors
  
  namespace :api , defaults: {format: :json} do 
    namespace :v1 do 
      resources :sensors
    end 
  end
end
