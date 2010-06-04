class Permissions < Aegis::Permissions
  #checking permission works as this:y
  #<% if current_user.may_update_project? @project %>
  #  <%= link_to 'Edit', edit_project_path(@project) %>
  #<% end %>
  
  
  missing_user_means { User.new(:role_name => 'guest') }
  missing_action_means :deny

  role :admin, :default_permission => :allow
  role :guest, :default_permission => :deny
  role :event_manager
  role :contact_manager

  resources :people do
    #update, create, destroy
    writing do
      allow :contact_manager
      deny  :event_manager
    end
    
   # action :create do
   #   deny :event_manager
   # end
    
    #show, index
    reading do 
      allow :contact_manager, :event_manager
    end
    
    #create read only actions:
    #action :foo, :writing => false  
  end
  
  resources :companies do
    writing do
      allow :contact_manager
      deny  :event_manager
    end
    
    reading do
      allow :contact_manager, :event_manager
    end
  end
  
  resources :events do
    writing do
      allow :event_manager
      deny  :contact_manager
    end
    
    reading do 
      allow :contact_manager, :event_manager
    end
  end
  
  resources :users do
    reading do
      allow :contact_manager, :event_manager
    end
    
    writing do
      deny :contact_manager, :event_manager
    end
  end
end
