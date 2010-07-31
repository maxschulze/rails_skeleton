source 'http://gemcutter.org'
source 'http://gems.github.com'

gem 'bundler', '1.0.0.rc.1'
gem "rails", "3.0.0.rc"

gem 'sqlite3-ruby', '1.2.5', :require => 'sqlite3' # freeze to 1.2.5, 1.3 does not work on app1
gem 'mysql'

gem 'simple_form'
# gem 'rack-offline', 
#     :git => 'git@github.com:maxschulze/rack-offline.git'
gem 'devise', '1.1.rc1'
gem 'aegis',
    :git => 'git://github.com/fearoffish/aegis.git',
    :branch => 'rails3'
gem 'will_paginate', 
    :git => 'git://github.com/mislav/will_paginate.git',
    :branch => 'rails3',
    :require => 'will_paginate'
gem 'thinking-sphinx', :git => "git://github.com/quasor/thinking-sphinx.git", :branch => "rails3", :require => 'thinking_sphinx'
gem 'inherited_resources', '1.1.2'
gem 'has_scope'
gem 'responders'
gem 'hermes'
gem "aasm",
    :git => 'git://github.com/kangguru/aasm.git',
    :require => 'aasm'
gem 'riddle'
gem 'blockenspiel'

group :test do
  gem "rspec-rails", ">= 2.0.0.beta.8"
  gem 'autotest-rails'
  gem 'autotest'
  gem 'autotest-growl'
  gem 'mocha'
  gem "capybara"
  gem "launchy"
  gem 'selenium-webdriver'
  gem 'factory_girl', ">=1.2.3", 
      :git => "git://github.com/thoughtbot/factory_girl.git", 
      :branch => "rails3", 
      :require => "factory_girl"
end

group :development do
  gem 'wirble'
  gem 'annotate'
  gem 'ruby-debug'
end
