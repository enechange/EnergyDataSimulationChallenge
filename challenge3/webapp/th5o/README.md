# README for Challenge 3 - Web Application

Describe the operating environment and how to up and run this Sample application.

## Runtime Environment

* PostgreSQL version
```
$ psql --version
psql (PostgreSQL) 10.3
```

* Ruby version
```
$ ruby -v
ruby 2.6.3p62
```

* Yarn version
```
$ yarn --version
1.12.3
```

## Initialize application

* Install gems
```
$ bundle install --path vendor/bundle
```

* Install javascript packages
```
$ yarn install
```

* Create database user
```
$ createuser -a -d -U postgres -P <username>
```

* Create and migrate database
```
$ bundle exec rails db:create
$ bundle exec rails db:migrate
```

* Initialize seed data
```
$ bundle exec rails db:seed
```

## Start application

* Rails application
```
$ bundle exec rails server

