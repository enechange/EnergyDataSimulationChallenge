# develop, production
threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
threads threads_count, threads_count
plugin :tmp_restart

# develop
environment ENV.fetch('RAILS_ENV') { 'development' }
port        ENV.fetch('PORT') { 3000 }

# production
# tmp_path = '/var/www/EnergyDataSimulationChallenge/challenge3/webapp/kumaki/tmp'
# bind "unix://#{tmp_path}/sockets/puma.sock"
# workers 2
# preload_app!
# pidfile "#{tmp_path}/pids/puma.pid"
