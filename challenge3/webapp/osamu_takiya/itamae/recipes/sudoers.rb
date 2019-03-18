remote_file "/etc/sudoers" do
  source '../source_files/sudoers'
  content 'Copy sudoers file'
  mode '440'
  owner 'root'
  group 'root'
end
