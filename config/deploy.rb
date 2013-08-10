# setup bundler
require "bundler/capistrano"

# cap -T to see available commands
load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"

# setup whenever to execute cron
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

server "198.199.64.159", :web, :app, :db, primary: true
set :port, '30007'
set :application, "blog"
set :user, "jrmy"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:jrmyward/blog.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do

  task :refresh_sitemaps do
    run "cd #{release_path} && bundle exec rake sitemap:refresh RAILS_ENV=#{rails_env}"
  end
  after 'deploy:update_code', 'deploy:refresh_sitemaps'

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads  #{release_path}/public/"
  end
  after 'deploy:update_code', 'deploy:symlink_uploads'

end