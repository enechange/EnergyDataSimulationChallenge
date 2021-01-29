FactoryBot.define do
  factory :plan do
    name { "ずっとも電気１" }
    provider_name { "東京ガス" }
    basic_charge {
      [
        {
          "ampere": 30,
          "amount": 858.0
        },
        {
          "ampere": 40,
          "amount": 1144.0
        },
        {
          "ampere": 50,
          "amount": 1430.0
        },
        {
          "ampere": 60,
          "amount": 1716.0
        }
      ]
    }
    energy_charge {
      [
        {
          "cost_per_kwh": 23.67,
          "range": {
            "from_kwh": 0,
            "to_kwh":  140
          }
        },
        {
          "cost_per_kwh": 23.88,
          "range": {
            "from_kwh": 141,
            "to_kwh":  350
          }
        },
        {
          "cost_per_kwh": 26.41,
          "range": {
            "from_kwh": 351,
            "to_kwh":  99999
          }
        }
      ]
    }
  end
end
