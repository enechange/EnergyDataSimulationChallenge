# Rails as API Backend Server

## Prerequisites

- Ruby 2.6.5
- Rails 6.0.2
- docker-compose 1.17.1

## Deployments Steps

#### Environment variables

```
$ export COMPOSE_FILE=docker-compose.prod.yml
```

#### Master Key

- make sure `master.key` does exist

```
$ ls config/master.key
```

#### Spinning up containers

```
$ docker-compose build --no-cache
$ docker-compose up
```

#### Setup Database

```
$ docker-compose exec rails_app bundle exec rails db:create db:migrate
```

#### Load CSV data into Database

```
$ docker-compose exec rails_app rails runner lib/tasks/load_csv_files.rb
```
