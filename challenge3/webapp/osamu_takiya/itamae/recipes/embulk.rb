USERNAME        = ENV['USERNAME'].freeze
HOME_DIRECTORY  = "/home/#{USERNAME}".freeze

execute 'Install Embulk' do
  user USERNAME
  command 'curl --create-dirs -o ~/.embulk/bin/embulk -L "https://dl.embulk.org/embulk-latest.jar" && chmod +x ~/.embulk/bin/embulk'
end

execute 'Install Embulk gems' do
  user USERNAME
  command '~/.embulk/bin/embulk gem install embulk-output-mysql && ~/.embulk/bin/embulk gem install embulk-filter-column && ~/.embulk/bin/embulk gem install embulk-filter-ruby_proc'
end
