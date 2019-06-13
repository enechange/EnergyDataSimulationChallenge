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

```graphql
{
  datasets(queryJson: "{\"house_city_name_cont\":\"Oxford\", \"energy_production_gteq\": 1000}") {
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