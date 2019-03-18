%w(nginx).each do |pkg|
  package pkg do
    action :install
  end
end
