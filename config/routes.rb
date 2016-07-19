Rails.application.routes.draw do
  resources :sensors
  
  match 'incluir' => 'sensors#create', :via => [:get, :post]
  
  root 'application#hello'
end
