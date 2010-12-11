Securedin::Application.routes.draw do
  # Offline Application Manifest File
  # match "/application.manifest" => Rails::Offline

  # devise_for :users
  # resource :user, :only => [:edit, :update]
  # resources :users, :except => [:edit, :destroy, :update]

  if Rails.env.cucumber? or Rails.env.test?
    match "login/:username", :controller => "users", :action => "backdoor"
  end

  match "dashboard", :to => "dashboard#show", :as => 'dashboard'
  root :to => "dashboard#show"
end
