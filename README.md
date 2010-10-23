# Changelog

## 23. Oktober 2010

* Gemfile: bumping devise to latest omniauth branch from github, for omniauth
* Gemfile: added omniauth/dependencies to Gemfile
* Gemfile: froze all versions in Gemfile for more stable development environment for all developers
* Gemfile: updated thinking sphinx to 2.0.0.rc2 from rubygems instead of github
* Gemfile: switched 'AASM' in favor of active model implementation 'transitions'
* Gemfile: removed pdf-reader and rubyzip, httpclient, because not needed
* Gemfile: Switched paperclip in favor of dragonfly for image uploads
* Gemfile: Updated rspec to 2.0 stable release

## 18. Oktober 2010

* update to rails 3.0.1
* change doc-style to markdown
* updated documentation to reflect setup for ruby 1.9.2 and cucumber
* kicked unnecessary javascript and css files
* removed not needed rails modules

## 1. September 2010

* update to mysql2 (dryed up the database.yml)
* update to Rails 3 Release
* change factory_girl to factory_girl_rails
* add factory_girl_rails to the development group, in order to have fast access to factories within the console
* added rspec-rails to the development group, to enable rspec rake tasks in development mode
* removed autotest from Gemfile to let bundler resolve the dependency
* Added Bundler.setup to the rake file, to ensure all gems are required
* removed view_specs and stylesheets from scaffolding
* updated the boot.rb to match the current Rails 3 boot process
* added active_support deprecation config
* removed i18n_database (commented it out)
* updated the factories to match the user model
* using the mocha mocking framework with rspec
* add a spec for the user, just to have a starting point

# Skeleton Specs

* Devise user / migration / aegis roles
* 960gs CSS / reset css / jquery / ujs / various plugins
* rspec / capybara / autotest / selenium (optional in rspec helper)

# Setup

## RVM

* Create .rvmrc file with: `echo rvm --create 1.9.2-p0@mylinkpower"`

## Bundler

* Install latest bundler 1.0.0.rc6 with `gem install bundler --pre`
* Install gems with `bundle`

### Bundler issues

In case you run into an issue with bundler that looks like this:

.bc Valid types are [:development, :runtime], not nil (ArgumentError)

Please make sure to install a recent bundler `gem install bundler --pre` does the trick. Even the 1.0.0 relase doesn't fix this issue.

## git

Install missing plugins which are defined as submodules

* `git submodules init`
* `git submodules update`

## Application setup

* Change database.yml to fit your local configuration

## Rake

* `rake db:create:all`
* `rake db:migrate`
* `rake db:test:clone`
* `rake db:seed`
* `rake ts:conf` Only for sphinx if needed

## Tests

* start `rake spec` to test factories and specs
* or start `autotest` to get into autotesting mode
* start autotest with `AUTOFEATURE=true autotest` to start autotest with cucumber
* Run `rake cucumber:all` to run all cucumber feature tests

