# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

set :user, 'y-shinada'
set :rails_env, 'staging'

set :branch, ENV['BRANCH'] || 'master'

set :bundle_flags, '--deployment'
set :bundle_path, shared_path.join('vendor', 'bundle')

set :rbenv_path, '/opt/anyenv/envs/rbenv'
set :rbenv_ruby, '2.5.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log, "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_tag, fetch(:application)
set :puma_worker_timeout, 60
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

set :nginx_flag_options, {
  max_fails: 2,
  fail_timeout: 60,
}
set :nginx_flags, fetch(:nginx_flag_options).to_a.map { |a| a.join('=') }.join(' ')
set :nginx_server_names, [
  "localhost",
  "staging.hello-energy-personal.net",
]
set :nginx_server_name, fetch(:nginx_server_names).join(' ')
set :nginx_socket_flags, fetch(:nginx_flags)
# set :nginx_ssl_certificate, "/etc/ssl/certs/#{fetch(:nginx_config_name)}.crt"
# set :nginx_ssl_certificate_key, "/etc/ssl/private/#{fetch(:nginx_config_name)}.key"
set :nginx_use_ssl, false

server "54.178.170.155", user: fetch(:user), roles: %w{app db web}, ssh_options: {
  port: 22,
  forward_agent: true,
  keys: ['config/certs/hello-energy-pem.pem'],
}


# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
