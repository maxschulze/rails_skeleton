load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

set :project_root, File.dirname(__FILE__)

load 'config/deploy' # remove this line to skip loading any of the default tasks