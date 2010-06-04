Factory.define :person do |f|
  f.first_name            'Max'    
  f.last_name             'Schulze'
  f.salutation            'Dr. Prof.'
  f.title                 'CTO'    
  f.state                 'active' 
  f.important             false
  f.gender                'male'   
  f.birthdate             Date.new(1989, 9, 16)
  f.relationship_status   'single'
  f.notes                 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut'
  f.visible_to            1
  f.association           :company, :factory => :company
end

Factory.define :email_address do |f|
  f.address               'max.schulze@gmail.com'
  f.location              'work'
  f.association           :person, :factory => :person
end

Factory.define :phone_number do |f|
  f.number                '+491736124424'
  f.location              'work'
  f.association           :person, :factory => :person
end

Factory.define :address do |f|
  f.street                'Gartenstr. 1'
  f.zip                   10115
  f.country               'Germany'
  f.city                  'Berlin'
  f.location              'work'
  f.association           :person, :factory => :person
end

Factory.define :instant_messenger do |f|
  f.address               'max.schulze@gmail.com'
  f.protocol              'Google Talk'
  f.location              'work'
  f.association           :person, :factory => :person
end

Factory.define :web_address do |f|
  f.url                   'http://www.maxschulze.com'
  f.location              'Personal'
  f.association           :person, :factory => :person
end

Factory.define :web_presence do |f|
  f.url                   'http://facebook.com/maxschulze'
  f.network               'Facebook'
  f.location              'Personal'
  f.association           :person, :factory => :person
end

Factory.define :company do |f|
  f.title                 'Urbanvention UG'
end

Factory.define :group do |f|
  f.title                 'Privat'
end

Factory.define :user do |f|
  f.first_name            'Benjamin'
  f.last_name             'Mateev'
  f.user_name             'benjamin.mateev'
  f.email                 'ben@urbanvention.com'
  f.password              'secret'
  f.password_confirmation 'secret'
  f.role_name             'guest'
end

Factory.define :contact_manager, :parent => :user do |f|
  f.first_name            'Benjamin'
  f.last_name             'Mateev'
  f.user_name             'benjamin.mateev'
  f.email                 'ben@urbanvention.com'
  f.password              'secret'
  f.password_confirmation 'secret'
  f.role_name             'contact_manager'
end

Factory.define :event_manager, :parent => :user do |f|
  f.first_name            'Benjamin'
  f.last_name             'Mateev'
  f.user_name             'benjamin.mateev'
  f.email                 'ben@urbanvention.com'
  f.password              'secret'
  f.password_confirmation 'secret'
  f.role_name             'event_manager'
end

Factory.define :admin, :parent => :user do |f|
  f.first_name            'Benjamin'
  f.last_name             'Mateev'
  f.user_name             'benjamin.mateev'
  f.email                 'ben@urbanvention.com'
  f.password              'secret'
  f.password_confirmation 'secret'
  f.role_name             'admin'
end