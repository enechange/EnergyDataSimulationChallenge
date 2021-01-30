FactoryBot.define do
  factory :tokyo_gas, class: Plan do
    name { "ずっとも電気１" }
    provider_name { "東京ガス" }
    supporting_amp { [30, 40, 50, 60] }
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

  factory :tepco, class: Plan do
    name { "従量電灯B" }
    provider_name { "東京電力エナジーパートナー" }
    supporting_amp { [10, 15, 20, 30, 40, 50, 60] }
    basic_charge {
      [
        {
          "ampere": 10,
          "amount": 286.0
        },
        {
          "ampere": 15,
          "amount": 429.0
        },
        {
          "ampere": 20,
          "amount": 572.0
        },
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
          "cost_per_kwh": 19.88,
          "range": {
            "from_kwh": 0,
            "to_kwh":  120
          }
        },
        {
          "cost_per_kwh": 26.48,
          "range": {
            "from_kwh": 121,
            "to_kwh":  300
          }
        },
        {
          "cost_per_kwh": 30.57,
          "range": {
            "from_kwh": 301,
            "to_kwh":  99999
          }
        }
      ]
    }
  end

  factory :looop_denki, class: Plan do
    name { "おうちプラン" }
    provider_name { "Looopでんき" }
    supporting_amp { [10, 15, 20, 30, 40, 50, 60] }
    basic_charge {
      [
        {
          "ampere": 10,
          "amount": 0
        },
        {
          "ampere": 15,
          "amount": 0
        },
        {
          "ampere": 20,
          "amount": 0
        },
        {
          "ampere": 30,
          "amount": 0
        },
        {
          "ampere": 40,
          "amount": 0
        },
        {
          "ampere": 50,
          "amount": 0
        },
        {
          "ampere": 60,
          "amount": 0
        }
      ]
    }
    energy_charge {
      [
        {
          "cost_per_kwh": 26.40,
          "range": {
            "from_kwh": 0,
            "to_kwh":  99999
          }
        }
      ]
    }
  end
end
