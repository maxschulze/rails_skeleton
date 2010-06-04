# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(Rails)
require 'rspec/rails'
require 'capybara/rails' 
require 'capybara/dsl'

# require "selenium-webdriver"
# Selenium::WebDriver.for :chrome

Capybara.default_selector = :css
# Capybara.default_driver = :selenium

Rspec.configure do |config|
  config.mock_with :rspec
  
  config.use_transactional_examples = true
  # config.use_instantiated_fixtures = false
  
  config.include Capybara
  config.before(:all) do
    I18nDatabase::Locale.new( :code => 'en', :name => 'English' )
    I18nDatabase::Locale.new( :code => 'es', :name => 'Spanish' )
  end
end

include Devise::TestHelpers

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}