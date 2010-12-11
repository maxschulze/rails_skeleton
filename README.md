# Skeleton Specs

* Devise user / migration / aegis roles
* 960gs CSS / reset css / jquery / ujs / various plugins
* rspec / capybara / autotest / selenium (optional in rspec helper)

# Setup

## RVM

* Create .rvmrc file with: `echo rvm --create 1.9.2-p0@mylinkpower"`

## Bundler

* Install latest bundler 1.0.7 `gem install bundler`
* Install gems with `bundle`

## git

Install missing plugins which are defined as submodules

* `git submodules init`
* `git submodules update`

## Application setup

* Change database.yml to fit your local configuration

    cp config/database.yml.sample config/database.yml

## Rake

* `rake db:create:all`
* `rake db:migrate`
* `rake db:test:clone`
* `rake db:seed`

## Tests

* start tests with `rake`
