server ENV['CAPISTRANO_PRODUCTION_SERVER'], user: ENV['CAPISTRANO_PRODUCTION_USER'], roles: %w(web app db)

set :stage, :production
set :branch, :'challenge3/osamu_takiya'
set :deploy_to, ENV['CAPISTRANO_PRODUCTION_DEPLOY_TO']
set :rails_env, 'production'

set :ssh_options, {
  port: 22,
  forward_agent: true,
  keys: ENV['CAPISTRANO_PRODUCTION_SSH_KEY']
}

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.production.pid"
set :unicorn_config_path, "#{release_path}/config/unicorn.rb"
