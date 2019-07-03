# GraphQL Cheat Sheet
## Query
### Schema
```graphql
query introspectionQuery {
  __schema {
    queryType {
      fields {
        name
        description
        args { ...InputValue }
        type { kind }
      }
    }
    mutationType {
      fields {
        name
        description
        args { ...InputValue }
        type { kind }
      }
    }
  }
}

fragment InputValue on __InputValue {
  name
  description
  type { kind }
  defaultValue
}
```

### Ransack
```graphql
{
  datasets (
    q: {
      cityNameCont: "Oxford"
      # `city_name_cont: "Oxford"` also vaild
      energyProductionGteq: 600
      s: "energyProduction asc"
      # `s: ["energyProduction asc", "cityName desc"]` also vaild
    }
    page: 1, per: 20
  ) {
    id
    city { name }
    energyProduction
  }
}
```

## Mutation
### Update AppConfigs
```graphql
mutation {
  updateAppConfig(
    input: {
      appConfigs: {
        general: {
          allowGraphiql: true
        }
        challenge2: {
          totalWattUrl: "https://example.org/sample.csv"
        }
        challenge3: {
          houseDataUrl: "https://example.org/house.csv"
          # Partial update availble, here `datasetUrl` will not updated
          # datasetUrl: "https://example.org/datasets.csv"
        }
      }
    }
  ) {
    appConfigs {
      general { allowGraphiql }
      challenge2 { totalWattUrl }
      challenge3 { houseDataUrl, datasetUrl }
    }
  }
}
```
