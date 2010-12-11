# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] ||= "test"

require 'rubygems'

require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

# rspec
require 'rspec/rails'

# cucumber
require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
require 'cucumber/rails/world'
require 'cucumber/rails/rspec'
require 'cucumber/rails/active_record'
require 'cucumber/web/tableish'

# capybara
require 'capybara'
require 'capybara/rails'
require 'capybara/session'
require 'capybara/cucumber'
# require 'cucumber/rails/capybara_javascript_emulation'

Capybara.default_selector = :css

# email spec
require 'email_spec/cucumber'

# factory girl
require 'factory_girl'
require 'factory_girl/step_definitions'

ActionController::Base.allow_rescue = false
Cucumber::Rails::World.use_transactional_fixtures = true

require 'database_cleaner'

DatabaseCleaner.strategy = :truncation, { :except => %w[ translations ] }
DatabaseCleaner.clean