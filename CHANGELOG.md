# Changelog

## 12. December 2010

* Adde a setup script `thor setup:app`.

## 11. December 2010

* moved changelog into its own file
* moved cucumber configurations into its own files, to allow updates through rails generators
* removed autotest folder (rspec 2.2 finds rails if .rspec is present in project root)
* Add Gemfile.lock to our repositories
* updated rspec from 2.0.0 to 2.2.0
* removed spork as it's currently unstable with rails3
* added capistrano recipes
* removed autotest-related gems
* updated i18n
* cucumber steps and tasks updated
* removed old folders
* removed plugins in favor for gems
* Updated skeleton for cucumber
* Add ruby-debug for ruby 1.9.x

## 23. October 2010

* Gemfile: bumping devise to latest omniauth branch from github, for omniauth
* Gemfile: added omniauth/dependencies to Gemfile
* Gemfile: froze all versions in Gemfile for more stable development environment for all developers
* Gemfile: updated thinking sphinx to 2.0.0.rc2 from rubygems instead of github
* Gemfile: switched 'AASM' in favor of active model implementation 'transitions'
* Gemfile: removed pdf-reader and rubyzip, httpclient, because not needed
* Gemfile: Switched paperclip in favor of dragonfly for image uploads
* Gemfile: Updated rspec to 2.0 stable release

## 18. October 2010

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
