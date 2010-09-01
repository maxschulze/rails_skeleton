source 'http://gemcutter.org'
source 'http://gems.github.com'

gem "rails", "3.0.0"
#gem 'sqlite3-ruby', '1.2.5', :require => 'sqlite3' # freeze to 1.2.5, 1.3 does not work on app1
gem 'mysql2'

gem 'devise', '1.1.rc2'
gem "will_paginate", "~> 3.0.pre2"
gem 'thinking-sphinx', :require => 'thinking_sphinx', :git => "git://github.com/freelancing-god/thinking-sphinx.git", :branch => "rails3"
gem 'inherited_resources', '1.1.2'
gem 'has_scope'
gem 'responders'
gem "aasm", '2.1.5'
gem 'riddle'
gem 'blockenspiel'
gem 'pdf-reader'
gem 'rubyzip'
gem 'bcrypt-ruby'
gem 'colored'

group :test do
  gem "rspec-rails", "~> 2.0.0.beta.20"
  gem 'autotest-rails'
  gem 'autotest-growl'
  gem 'mocha'
  gem "capybara"
  gem "launchy"
  gem 'selenium-webdriver'
  gem 'factory_girl_rails'
end

group :development do
  # rspec needs to be in development to add rake tasks
  gem "rspec-rails", "~> 2.0.0.beta.20"
  gem 'factory_girl_rails'
  gem 'wirble'
  gem 'annotate'
  gem 'ruby-debug19'
  gem 'hirb'
  gem 'pdf-reader'
end
