%w(git software-properties-common vim).each do |pkg|
  package pkg do
    action :install
  end
end

# To build Ruby
%w(autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev).each do |pkg|
  package pkg do
    action :install
  end
end

# TODO: ndenv
%w(nodejs yarn).each do |pkg|
  package pkg do
    action :install
  end
end
