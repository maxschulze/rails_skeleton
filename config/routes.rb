Ems::Application.routes.draw do |map|
  resources :people do
    collection do
      get :search
    end
  end
  
  resources :companies do
    collection do
      get :search
    end
  end
  
  resources :groups do
    collection do
      get :search
    end
  end
  
  # Offline Application Manifest File
  # match "/application.manifest" => Rails::Offline

  devise_for :users
  resource :user, :only => [:edit]
  resources :users
  root :to => "dashboard#show"
  
end
