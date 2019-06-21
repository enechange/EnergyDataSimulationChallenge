# README

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
*both `camelCase` and `snack_case` are OK in ransack json*

```graphql
{
  datasets(queryJson: "{\"houseCityNameCont\":\"Oxford\", \"energy_production_gteq\": 1000}") {
    city {name},
    energyProduction
  }
}
```
**Results**

```json
{
  "data": {
    "datasets": [
      {
        "city": {
          "name": "Oxford"
        },
        "energyProduction": 1030
      },
      {
        "city": {
          "name": "Oxford"
        },
        "energyProduction": 1046
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
