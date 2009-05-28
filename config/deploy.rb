set :application, "expert"

ssh_options[:port] = 8586
ssh_options[:username] = "root"
ssh_options[:forward_agent] = true

set :user, "kukhl"
set :runner, "root"
set :scm_verbose, true 

#set :use_sudo, true

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:

set :deploy_to, "/var/www/apps/#{application}"
set :deploy_via, :remote_cache
default_run_options[:pty] = true

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

set :scm, :git
set :repository,  "git@kukhl.unfuddle.com:kukhl/expert.git"
set :branch, "master"
set :scm_passphrase, "gegrby"
 

role :app, "209.20.90.25"
role :web, "209.20.90.25"
role :db,  "209.20.90.25", :primary => true


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



after "deploy:update_code", :fix_script_perms


