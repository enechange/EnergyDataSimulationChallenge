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
```