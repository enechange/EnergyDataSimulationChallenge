server ENV['CAPISTRANO_DEVELOPMENT_SERVER'], user: ENV['CAPISTRANO_DEVELOPMENT_USER'], roles: %w(web app db)

set :stage, :development
set :branch, :'challenge3/osamu_takiya-development'
set :deploy_to, ENV['CAPISTRANO_development_DEPLOY_TO']
set :rails_env, 'development'

set :ssh_options, {
  port: 22,
  forward_agent: true,
  keys: ENV['CAPISTRANO_DEVELOPMENT_SSH_KEY']
}

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.development.pid"
set :unicorn_config_path, "#{release_path}/config/unicorn.rb"
