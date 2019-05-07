USERNAME        = ENV['USERNAME']
HOME_DIRECTORY  = "/home/#{USERNAME}".freeze

git "#{HOME_DIRECTORY}/.rbenv" do
  user USERNAME
  repository 'https://github.com/sstephenson/rbenv.git'
end

git "#{HOME_DIRECTORY}/.rbenv/plugins/ruby-build" do
  user USERNAME
  repository 'https://github.com/sstephenson/ruby-build.git'
end
