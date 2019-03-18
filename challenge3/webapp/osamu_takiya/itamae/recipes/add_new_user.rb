USERNAME        = ENV['USERNAME']
PASSWORD        = ENV['PASSWORD']
HOME_DIRECTORY  = "/home/#{USERNAME}".freeze

user 'Create a new user account' do
  username USERNAME
  password PASSWORD

  shell '/bin/bash'
  create_home true

  action :create
end

execute 'Add a new user to sudo group' do
  command "usermod -aG sudo #{USERNAME}"
end

execute 'Create .ssh directory if it does not exist' do
  user USERNAME
  command "mkdir -p #{HOME_DIRECTORY}/.ssh"
end

remote_file "#{HOME_DIRECTORY}/.ssh/authorized_keys" do
  source '../source_files/authorized_keys'
  content 'Copy SSH authorized_keys'
  mode '600'
  owner USERNAME
  group USERNAME
end
