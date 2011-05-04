# Skeleton Specs

* 960gs CSS / reset css / jquery / ujs / various plugins
* rspec / capybara / selenium (optional in rspec helper)

# Setup

In short:

1. setup rvmrc
2. install gems via bundler
3. thor setup:app MyAppName

## RVM

* Create .rvmrc file with: `echo rvm --create 1.9.2-p0@my_app_name"`

## Bundler

* Install latest bundler 1.0.7 `gem install bundler`
* Install gems with `bundle`

## Setup script

Setup the application with:

    thor setup:app my_app_name

And follow the instructions.
