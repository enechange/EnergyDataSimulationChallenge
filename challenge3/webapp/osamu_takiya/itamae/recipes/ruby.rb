USERNAME        = ENV['USERNAME']
HOME_DIRECTORY  = "/home/#{USERNAME}".freeze
RUBY_VERSION    = '2.5.5'.freeze

execute 'Build Ruby' do
  user USERNAME
  command "#{HOME_DIRECTORY}/.rbenv/bin/rbenv install -f #{RUBY_VERSION}"
end

execute 'Install Ruby' do
  user USERNAME
  command "#{HOME_DIRECTORY}/.rbenv/bin/rbenv global #{RUBY_VERSION}"
end

execute 'Install Bundler' do
  user USERNAME
  command "#{HOME_DIRECTORY}/.rbenv/shims/gem install bundler"
end

execute 'Install Rails' do
  user USERNAME
  command "#{HOME_DIRECTORY}/.rbenv/shims/gem install rails"
end
