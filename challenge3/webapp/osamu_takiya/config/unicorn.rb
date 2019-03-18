worker_processes 2
listen ENV['UNICORN_LISTEN']
timeout 30
pid ENV['UNICORN_PID']
stderr_path ENV['UNICORN_STDERR_PATH']
stdout_path ENV['UNICORN_STDOUT_PATH']

preload_app true

before_fork do |server, _worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # TODO: do something
    end
  end
end

before_exec do |_server|
  ENV['BUNDLE_GEMFILE'] = "#{Rails.root.join('Gemfile')}"
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end