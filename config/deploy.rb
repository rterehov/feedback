set :app, "feedback"
set :user, "feedback"
set :base_dir, "/home/#{user}"

require 'capistrano/ext/multistage'
set :default_stage, "production"
set :stages, %w(production)

set :normalize_asset_timestamps, false
set :keep_releases, 10

# repo settings
set :scm, :git
set :repository, "git@bitbucket.org:rterehov/#{app}.git"
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# servers settings
set :use_sudo, false

after "deploy", "deploy:thrift:make"
after "deploy:update", "deploy:cleanup" 

