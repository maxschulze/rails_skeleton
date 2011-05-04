source :rubygems

# core gems
gem "rails",                "~> 3.0.7"
gem "mysql2",               "~> 0.2.6"
gem "sqlite3-ruby",         "~> 1.3.1"
gem "yajl-ruby",            "~> 0.7.8"
gem "i18n-active_record",   :git => "git://github.com/svenfuchs/i18n-active_record.git", :require => "i18n/active_record"

# Devise
gem 'devise',               '1.3.3'
gem "oa-oauth",             :require => "omniauth/oauth"
gem 'cancan'

# Thinking Sphinx
# gem "thinking-sphinx",      "~> 2.0.0.rc2", :require => "thinking_sphinx"
# gem "riddle",               "~> 1.1.0"

# Inherited Resources
gem 'inherited_resources',  '~> 1.2.2'
gem "has_scope",            "~> 0.5.0"
gem "responders",           "~> 0.6.2"

# AASM
gem "state_machine",        '~> 0.10.4'

# Paperclip
gem "paperclip"

# Views
gem "dynamic_form",         "~> 1.1.3"
gem 'simple_form',          :git => "git://github.com/plataformatec/simple_form.git"

## Pagination
gem 'kaminari'

# Deployment
gem "capistrano"
gem "capistrano-ext"

gem 'awesome_print', :require => 'ap', :git => 'git://github.com/michaeldv/awesome_print.git'

group :test, :development, :cucumber do
  gem 'growl'
  gem 'watchr'
  gem 'rspec-rails'
  gem 'cucumber-rails', '>=0.4.0'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'spork', '~> 0.9.0.rc'
  gem 'launchy'
  gem 'akephalos'
  gem 'selenium'
  gem 'selenium-client'
  gem 'factory_girl_rails'
  gem 'nokogiri' # used to parse HTML output form QUnit tests
  gem 'email_spec', :git => 'git://github.com/bmabey/email-spec.git', :branch => 'rails3'
  gem "rspec-rails-matchers", :git => "https://github.com/sinefunc/rspec-rails-matchers.git" # dry rspec
  gem 'hpricot'
  gem 'ruby_parser'
  gem 'rr'
end
