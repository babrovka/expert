require 'bundler/capistrano'
require "rvm/capistrano"

set :application, "carexpert"
set :rvm_ruby_string, 'ruby-1.9.3-p194'
set :rvm_type, :system

nodes = [
  '213.239.211.2'
]

role :app, *nodes
role :web, *nodes
role :db,  nodes.first, :primary => true

set :scm, :git
set :user, "carexpert"
set :password, "carbagus"
set :use_sudo, false

set :deploy_via, :remote_cache

set :keep_releases, 15
set :normalize_asset_timestamps, false

set :repository,  "git@bitbucket.org:paxa/expert.git"

set :deploy_to, "/srv/apps/#{application}"

set :branch, 'master'

THIN_COMMAND = "bundle exec thin -R config.ru -e production -d -a 0.0.0.0 -p 50000"


namespace :deploy do
  task :start, :roles => :app do
    run "cd #{latest_release} && #{THIN_COMMAND} start"
  end

  task :stop, :roles => :app do
    run "cd #{latest_release} && #{THIN_COMMAND} stop"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{latest_release} && (#{THIN_COMMAND} stop || test 1) && #{THIN_COMMAND} start "
  end

  task :precompile_assets do
    run "cd #{release_path} && RAILS_ENV=production bundle exec rake assets:precompile"
  end

  task :symlink, :roles => :app do
    run <<-CMD
      rm -rf #{release_path}/downloads &&
      ln -nfs #{shared_path}/downloads #{release_path}/downloads
    CMD
  end
end

after 'deploy:update_code', 'deploy:precompile_assets'
after "deploy:update_code", "deploy:symlink"
