lock '~> 3.11.0'

set :application, 'enechange'
set :repo_url, ENV['CAPISTRANO_REPO_URL']
set :rbenv_type, :user
set :rbenv_ruby, '2.5.5'

set :linked_dirs,
    %w(
      log
      tmp/pids
      tmp/cache
      tmp/sockets
      bundle
      public/system
      public/uploads
    )
set :linked_files, ['config/master.key']

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end
