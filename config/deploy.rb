# config valid only for Capistrano 3.10
lock '~> 3'

set :application, 'harmanpro'
#set :repo_url, 'https://github.com/harman-signal-processing/harmanpro'
set :repo_url, 'ssh://git@github.com/harman-signal-processing/harmanpro.git'

set :ssh_options, compression: false, keepalive: true
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
#set :pty, true
#set :passenger_restart_with_sudo, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml config/secrets.yml config/s3.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets}
#set :bundle_binstubs, nil

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

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
