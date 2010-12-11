set :application, "securedin" # change me
set :user,        'deploy'
set :password,    ''

set :scm,         "git"
set :branch,      "master"
set :repository,  "git@uv:securedin.git"
set :git_enable_submodules, 1

set :rails_env,   "production"
set :deploy_to,   "/home/applications/#{application}"
set :deploy_via,  :remote_cache

role :app,        "188.165.119.69"
role :web,        "188.165.119.69"
role :db,         "188.165.119.69", :primary => true

set :use_sudo, false
ssh_options[:paranoid] = false

namespace :deploy do

  desc "Restart Application"
  task :restart, :roles => :app do
    ['system'].each do |link|
      puts "create Symlink for #{link}"
      run "ln -nfs  #{deploy_to}/shared/public/#{link} #{deploy_to}/current/public/#{link}"
    end

    run "touch #{deploy_to}/current/tmp/restart.txt"
  end

  desc "Start Search"
  task :search_start, :roles => :app do
    run "cd #{current_path} && rake ts:start RAILS_ENV=#{rails_env}"
  end

  desc "Stop Search"
  task :search_stop, :roles => :app do
    run "cd #{current_path} && rake ts:stop RAILS_ENV=#{rails_env}"
  end

  desc "Rebuild Search"
  task :search_rebuild, :roles => :app do
    run "cd #{current_path} && rake ts:rebuild RAILS_ENV=#{rails_env}"
  end

  desc "Index Search"
  task :search_index, :roles => :app do
    run "cd #{current_path} && rake ts:in RAILS_ENV=#{rails_env}"
  end

  desc "Symlink Sphinx"
  task :symlink_sphinx_indexes, :roles => [:app] do
    run "ln -nfs #{deploy_to}/shared/db/sphinx #{deploy_to}/current/db/sphinx"
  end

end

namespace :cache do
  desc "Clear memcache after deployment"
  task :clear, :roles => :app do
    run "cd #{current_path} && rake cache:clear RAILS_ENV=#{rails_env}"
  end
end

after "deploy", "deploy:cleanup"
after "deploy", "cache:clear"
after "deploy", "deploy:search_rebuild"