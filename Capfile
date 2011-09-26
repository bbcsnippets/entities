load 'deploy' if respond_to?(:namespace) # cap2 differentiator

# Uncomment if you are using Rails' asset pipeline
# load 'deploy/assets'

set :application, "entities"

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git://github.com/matth/entities.git"  # Your clone URL
set :scm, "git"
set :user, "www-data"
set :use_sudo, false
set :branch, "master"
ssh_options[:forward_agent] = true

set :deploy_via, :remote_cache
set :keep_releases,5

role :web, "berlin.bbcsnippets.co.uk"
role :app, "bbcsnippets.co.uk"

#If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
end

namespace :bundler do
  task :create_symlink, :roles => :app do
    # Bundle dir
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end

  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install --path /home/www-data/.bundler/ --without test sqlite"
  end
end

after 'deploy:update_code', 'bundler:bundle_new_release'
