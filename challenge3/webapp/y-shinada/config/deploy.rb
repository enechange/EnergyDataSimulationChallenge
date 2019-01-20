# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "hello-energy"
set :repo_url, "git@github.com:y-shinada/hello-energy.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
append :linked_files, *%w(config/database.yml config/master.key)

# Default value for linked_dirs is []
append :linked_dirs, *%w(log tmp/pids tmp/cache tmp/sockets public/system vendor/bundle)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :assets_manifests, []

Rake::Task["deploy:assets:precompile"].clear
Rake::Task["deploy:assets:backup_manifest"].clear
Rake::Task["deploy:assets:restore_manifest"].clear
Rake::Task['deploy:cleanup_assets'].clear
Rake::Task['deploy:clobber_assets'].clear
Rake::Task['deploy:normalize_assets'].clear
Rake::Task['deploy:rollback_assets'].clear
namespace :deploy do
  task :cleanup_uncompile_assets do
    on roles(:web) do
      subdirs = Dir.glob('app/assets/javascripts/**/**.js').map { |f| shared_path.join(File.dirname(f.gsub(/\Aapp/, 'public'))) }.uniq
      subdirs.each do |f|
        info "Cleanup #{f}"
        execute :rm, "-rf", f
      end
    end
  end

  task :deliver_uncompile_assets do
    on roles(:web) do
      Dir.glob('app/assets/javascripts/**/**.js').each do |f|
        subdir = shared_path.join(File.dirname(f.gsub(/\Aapp/, 'public')))
        execute :mkdir, "-p", subdir
        info "Uploading #{f} to public"
        upload! File.open(f), subdir.join(File.basename(f))
      end
    end
  end
end

after 'deploy:symlink:release', 'deploy:cleanup_uncompile_assets'
after 'deploy:cleanup_uncompile_assets', 'deploy:deliver_uncompile_assets'
