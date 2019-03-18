%w(language-pack-ja language-pack-ja-base).each do |pkg|
  package pkg do
    action :install
  end
end

execute 'update locale to ja' do
  command 'sudo update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"'
end

execute 'Change Timezone to Asia/Tokyo' do
  command 'sudo timedatectl set-timezone Asia/Tokyo'
end

execute '. /etc/default/locale' do
  action :run
end
