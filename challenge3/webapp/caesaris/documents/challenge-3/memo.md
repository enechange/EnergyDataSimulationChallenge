# Memo:
## Load Houses
```rb
# Load House
> uri = "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/house_data.csv"
> DataLoader.load_houses(uri)
> DataLoader.load_cities
> DataLoader.sync_cities_houses

# Load Dataset
> uri = "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/dataset_50.csv"
> DataLoader.load_dataset(uri)
```

## GraphQL
**Query**  
*both `camelCase` and `snack_case` are OK in ransack query*

```graphql
{
  datasets(q: {
    # houseCityNameCont: "Oxford",
    cityNameCont: "Oxford",
    energy_production_gteq: 600,
    s: "cityName desc",
  }, page: 2, per: 20) {
    id,
    city {name},
    energyProduction,
  }
}
```
**Results**

```json
{
  "data": {
    "datasets": [
      {
        "id": "1102",
        "city": {
          "name": "Oxford"
        },
        "energyProduction": 623
      },
      {
        "id": "1094",
        "city": {
          "name": "Oxford"
        },
        "energyProduction": 694
      },
      {
        "id": "935",
        "city": {
          "name": "Oxford"
        },
        "energyProduction": 752
      },
      {
        "id": "934",
        "city": {
          "name": "Oxford"
        },
        "energyProduction": 668
      },
      {
        "id": "933",
        "city": {
          "name": "Oxford"
        },
        "energyProduction": 667
      }
    ]
  }
}
```

## Init Admin Page
**Web page is a submodule in `vendor/admin`**

```sh
$ cd vendor/admin
$ yarn install

# for development
$ yarn serve

# for production
$ yarn build

# add new svg icon
$ cp YOUR_ICON.svg ./src/icons/svg
$ npx vsvg -s ./src/icons/svg -t ./src/icons/components --ext ts --es6
```

## Deploy
### Set Environment Variables!

*eg:*

```sh
#### For Rails(API) ####
ENV=production
RAILS_ENV=production

SHOW_DEFAULT_USER=1
DEFAULT_USER_EMAIL=admin@example.com
DEFAULT_USER_PASSWORD=admin2019

# RAILS_MASTER_KEY=XXXXXXXXXXXXXXX # upper than rails 5.2
# use `bundle exec rake secret` to generate one
SECRET_KEY_BASE=XXXXXXXXXXXXXXX

RAILS_SERVE_STATIC_FILES=1 # Unless serve static files by your own

#### For Node(Admin) ####
# NODE_ENV=production
VUE_APP_NAME=Iuliana Challenges

#### For Docker Dev ####
POSTGRES_PASSWORD=XXXXXXXXXXXXXXX
```

### Migration
```sh
$ docker-compose run web bundle exec rake db:create db:migrate
```

### debug
```sh
$ docker-compose run web bundle exec rails c
$ docker-compose run web bin/bash
$ docker-compose exec web bash
```


## Test
### Rails
```sh
$ bundle exec rspec # 97.51%
```

### Vue
```sh
$ cd vendor/admin
$ yarn test:unit # 94.12%, not completed
```

### Heroku
```sh
heroku login
heroku create iuliana-challenges
heroku container:login
heroku addons:create heroku-postgresql:hobby-dev -a iuliana-challenges
heroku container:push web -a iuliana-challenges
heroku container:release web -a iuliana-challenges
heroku run bundle exec rails db:migrate -a iuliana-challenges

### ENV ###
heroku config:set RAILS_ENV=production -a iuliana-challenges
heroku config:set DEFAULT_USER_EMAIL="USERNAME@example.com" -a iuliana-challenges
heroku config:set DEFAULT_USER_PASSWORD="PASSWORD" -a iuliana-challenges
heroku config:set SECRET_KEY_BASE="XXXXXXXXXX" -a iuliana-challenges
heroku config:set TZ=Asia/Tokyo -a iuliana-challenges
heroku config:set RAILS_SERVE_STATIC_FILES=1 -a iuliana-challenges

### Debug ###
heroku logs --tail -a iuliana-challenges
heroku run bash -a iuliana-challenges
# heroku run bundle exec rails c -a iuliana-challenges
```

```Dockerfile
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
```
