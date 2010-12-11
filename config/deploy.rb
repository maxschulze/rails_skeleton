require 'capistrano/ext/multistage'
require "bundler/capistrano"

set :stages, %w(production)
set :default_stage, "production"