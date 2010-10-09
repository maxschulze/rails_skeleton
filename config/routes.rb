Ems::Application.routes.draw do
  # Offline Application Manifest File
  # match "/application.manifest" => Rails::Offline

  devise_for :users, :controllers => { :registrations => 'registrations' }
  resource :user, :only => [:edit, :update]

  match 'user/privacy_settings'       => 'users#privacy_settings',      :as => :privacy_settings_user
  match 'user/notification_settings'  => 'users#notification_settings', :as => :notification_settings_user

  resources :users, :except => [:edit, :destroy, :update]

  if Rails.env.cucumber? or Rails.env.test?
    match "login/:username", :controller => "users", :action => "backdoor"
  end

  root :to => "dashboard#show"
  match "dashboard", :to => "dashboard#show", :as => 'dashboard'

end
