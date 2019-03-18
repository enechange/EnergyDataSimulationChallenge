%w(openjdk-8-jre).each do |pkg|
  package pkg do
    action :install
  end
end
