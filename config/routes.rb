Ems::Application.routes.draw do |map|
  # Offline Application Manifest File
  # match "/application.manifest" => Rails::Offline

  devise_for :users
  resource :user, :only => [:edit]
  resources :users
  
  root :to => "dashboard#show"
  
end
