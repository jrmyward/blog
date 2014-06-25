# config valid only for Capistrano 3.1
lock '3.2.1'

SSHKit.config.command_map[:rake] = "bundle exec rake"
SSHKit.config.command_map[:whenever] = "bundle exec whenever"

set :rbenv_type, :system
set :rbenv_custom_path, '/opt/rbenv'
set :rbenv_ruby, '2.1.2'

set :user, "ocd"
set :application, 'jrmyward'
set :repo_url, 'git@github.com:jrmyward/blog.git'
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :ssh_options, {
  forward_agent: true,
  port: 30007
}

set :log_level, :debug

# Default value for :pty is false
# set :pty, true

set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

set :rails_env, 'production'
set :sidekiq_pid, File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid')

set :keep_releases, 3

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
