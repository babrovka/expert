set :application, "expert"

ssh_options[:port] = 8587
ssh_options[:username] = "kukhl"
ssh_options[:forward_agent] = true

set :user, "kukhl"
set :runner, "root"
set :scm_verbose, true 

#set :use_sudo, true

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:

set :deploy_to, "/var/www/apps/#{application}"
#set :deploy_via, :remote_cache
default_run_options[:pty] = true

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

set :scm, :git
set :repository,  "git@kukhl.unfuddle.com:kukhl/expert.git"
set :branch, "master"
set :scm_passphrase, "gegrby"
 

role :app, "74.207.226.126"
role :web, "74.207.226.126"
role :db,  "74.207.226.126", :primary => true

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end


task :fix_script_perms do
  run "chmod 755 #{latest_release}/script/spin"
end

#namespace :deploy do
# desc "Create asset packages for production" 
# task :after_update_code, :roles => [:web] do
#   run <<-EOF
#     cd #{release_path} && rake asset:packager:build_all
#   EOF
# end
#end

namespace :assets do
  task :symlink, :roles => :app do
    assets.create_dirs
    run <<-CMD
      rm -rf #{release_path}/downloads &&
      ln -nfs #{shared_path}/downloads #{release_path}/downloads
    CMD
  end
  task :create_dirs, :roles => :app do
    run "mkdir -p #{release_path}/downloads"
  end
end


after "deploy:update_code" , "assets:symlink"
after "deploy:update_code", :fix_script_perms


