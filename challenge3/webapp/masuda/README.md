# README
## demo site
http://35.193.179.138/
## version
debian 10
ruby 2.6.5
rails 6.0.0
node 10.15.3
vue 3.11.0
postgresql-11
apache2

# set up
## postgres
sed -i s/peer/trust/ /etc/postgresql/11/main/pg_hba.conf
psql -U postgres -q -c"ALTER USER postgres WITH PASSWORD 'password';"
psql -U postgres -q -c"CREATE DATABASE graph;"

## vue.js
npm install
npm run build
cp -r dist/* /var/www/html/

## rails
bundle install
rails db:migrate
rake house_data_csv:import
rake data_set_50_csv:import

## TODO
ユニットテスト
モデルでのバリデーション

