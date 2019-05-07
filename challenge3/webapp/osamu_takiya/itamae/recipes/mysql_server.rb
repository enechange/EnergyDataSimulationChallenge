# To login, "$ sudo mysql"
%w(mysql-server libmysqlclient-dev).each do |pkg|
  package pkg do
    action :install
  end
end
