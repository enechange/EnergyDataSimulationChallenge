USERNAME        = ENV['USERNAME'].freeze
HOME_DIRECTORY  = "/home/#{USERNAME}".freeze

execute 'Create a .ssh directory if it does not exist' do
  user USERNAME
  command "mkdir -p #{HOME_DIRECTORY}/.ssh"
end

remote_file "#{HOME_DIRECTORY}/.ssh/github.pem" do
  source '../source_files/github.pem'
  content 'Copy GitHub SSH private key'
  mode '600'
  owner USERNAME
  group USERNAME
end

# 仮の .ssh/config を最初に送る
remote_file "#{HOME_DIRECTORY}/.ssh/config" do
  source '../source_files/config'
  content 'Copy SSH config base file'
  mode '600'
  owner USERNAME
  group USERNAME
end

# 送った .ssh/config の中の、鍵の path を設定する（環境変数を用いて DRY に）
file "#{HOME_DIRECTORY}/.ssh/config" do
  action :edit
  block do |content|
    content.gsub!('IDENTITY_FILE_PATH', "~/.ssh/github.pem")
  end
end
