# EnergyDataSimulationChallenge Challenge3

## Requirements

* Ruby 2.3.0 (installed by [rbenv](http://rbenv.org))
* [Bundler](http://bundler.io/)
* [Bower](http://bower.io/)

## How to Use

install rubygems

```bash
$ bundle install --path=vendor/bundle
```

install bower components

```bash
$ bundle exec rake bower:install
```

setup database

```bash
$ bundle exec rake db:create
$ bundle exec rake db:migrate
```

insert sample data to database

```bash
$ bundle exec rake data:import_house
$ bundle exec rake data:import_energy
```
