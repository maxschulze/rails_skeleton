$LOAD_PATH << File.join(Dir.pwd, 'lib')
puts $LOAD_PATH

require 'capistrano/ext/multistage'
require "bundler/capistrano"
require "recipes/database"

set :stages, %w(staging)
set :default_stage, "staging"