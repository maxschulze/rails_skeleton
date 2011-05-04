

require 'spork'
 
Spork.prefork do
  require 'cucumber/rails'
  require 'rr'
  Cucumber::Rails::World.send(:include, RR::Adapters::RRMethods)
  Cucumber::Rails::World.send(:include, RR::Adapters::TestUnit)

  Capybara.default_selector = :css

end
 
Spork.each_run do
  ActionController::Base.allow_rescue = false
  
  begin
    DatabaseCleaner.strategy = :transaction
  rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
  end

end

require 'selenium/client'
require 'akephalos'
Capybara.javascript_driver = :akephalos
Capybara.default_wait_time = 5