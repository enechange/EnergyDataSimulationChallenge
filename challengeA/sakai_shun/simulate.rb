require 'pp'

class Simulator
  attr_reader :contract_amp, :usage, :power_companies

  def initialize(contract_amp, usage, *power_companies)
    @contract_amp = contract_amp
    @usage = usage
    @power_companies = power_companies
  end

  def simulate
    result = plans.plans.map do |plan|

      {
        provider_name: plan.provider_name,
        plan_name: plan.name,
        price: price[plan.name.to_sym]
      }
    end
    return result
  end

  private

  def plans
    plans ||= Plans.new(power_companies)
  end

  def basic_price
    plans.basic_price(contract_amp)
  end

  def energy_price
    plans.energy_price(usage)
  end

  def price
    result = {}
    prices = basic_price.concat(energy_price)
    plans.plans.map do |plan|
      price = prices.sum{_1[plan.name.to_sym] || 0}
      result[plan.name.to_sym] = price
    end

    return result
  end
end

class Plans
  attr_reader :plans

  def initialize(plans)
    @plans = plans
  end

  def basic_price(contract_amp)
    basic_fees = []

    plans.map do |plan|
      plan.basic_charge.map do |usage_fee|
        if usage_fee[:ampere] == contract_amp
          basic_fee = usage_fee[:amount]
          basic_fees << { plan.name.to_sym => basic_fee }
        end
      end
    end
    # pp basic_fees
    return basic_fees
  end

  def energy_price(usage)
    energy_fees = []

    plans.map do |plan|
      plan.energy_charge.map do |fee_structure|
        range = Range.new(fee_structure[:range][:from_kwh], fee_structure[:range][:to_kwh])
        if range.cover?(usage)
          energy_fee = usage * fee_structure[:cost_per_kwh]
          energy_fees << { plan.name.to_sym => energy_fee }
        end
      end
    end
    return energy_fees
  end
end

class Plan
  attr_accessor :name, :provider_name, :basic_charge, :energy_charge

  def initialize(args)
    @name = args[:name]
    @provider_name = args[:provider_name]
    @basic_charge = args[:basic_charge]
    @energy_charge = args[:energy_charge]
  end
end

tokyo_gas = Plan.new(
  name: "ずっとも電気１",
  provider_name: "東京ガス",
  basic_charge: [
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
  ],
  energy_charge: [
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
        "from_kwh": 140,
        "to_kwh":  350
      }
    },
    {
      "cost_per_kwh": 26.41,
      "range": {
        "from_kwh": 350,
        "to_kwh":  99999
      }
    }
  ]
)

tepco = Plan.new(
  name: "従量電灯B",
  provider_name: "東京電力エナジーパートナー",
  basic_charge: [
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
  ],
  energy_charge: [
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
        "from_kwh": 120,
        "to_kwh":  300
      }
    },
    {
      "cost_per_kwh": 30.57,
      "range": {
        "from_kwh": 300,
        "to_kwh":  99999
      }
    }
  ]
)

looop_denki = Plan.new(
  name: "おうちプラン",
  provider_name: "Looopでんき",
  basic_charge: [
    {
      "ampere": 10,
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
  ],
  energy_charge: [
    {
      "cost_per_kwh": 26.40,
      "range": {
        "from_kwh": 0,
        "to_kwh":  99999
      }
    }
  ]
)

# 第一引数：契約アンペア、第二引数：1ヶ月の使用量(kWh)
simulator = Simulator.new(10, 280, tokyo_gas, tepco, looop_denki)
p simulator.simulate
