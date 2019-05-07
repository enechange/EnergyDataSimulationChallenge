USERNAME        = ENV['USERNAME']
HOME_DIRECTORY  = "/home/#{USERNAME}".freeze

%w(zsh).each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "#{HOME_DIRECTORY}/.zshrc" do
  source '../source_files/.zshrc'
  content 'Copy zsh config file'
  owner USERNAME
  group USERNAME
end

# TODO: chsh_to_zsh_root の場合も作る（DRYにする）
remote_file "#{HOME_DIRECTORY}/chsh_to_zsh.sh" do
  source '../source_files/chsh_to_zsh.sh'
  content 'Copy changing shell to zsh file (Shell script)'
  mode '755'
  owner USERNAME
  group USERNAME
end

execute 'Change default shell to zsh' do
  user USERNAME
  command "#{HOME_DIRECTORY}/chsh_to_zsh.sh"
end

file "#{HOME_DIRECTORY}/chsh_to_zsh.sh" do
  action :delete
end
