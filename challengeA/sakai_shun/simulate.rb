class Simulator
  attr_reader :calculator

  def initialize(contract_amp, usage, tokyo_gas, tepco, looop_denki)
    @calculator = Calculator.new(
      contract_amp,
      usage,
      tokyo_gas,
      tepco,
      looop_denki
    )
  end

  # [{provider_name: "Looopでんき", plan_name: "おうちプラン", price: 1234}, ...]の形で返ってくることを期待する
  def simulate
    plans = calculator.calculate
    puts plans
  end
end

class Calculator
  attr_reader :contract_amp, :usage, :plans

  def initialize(contract_amp, usage, tokyo_gas, tepco, looop_denki)
    @contract_amp = contract_amp
    @usage = usage
    @plans = Plans.new([tokyo_gas, tepco, looop_denki])
  end

  # [{provider_name: "Looopでんき", plan_name: "おうちプラン", price: 1234}, ...]の形で返す
  def calculate
    prices = basic_price.zip(energy_price).map { |a, b| a + b }
    plans.plans.map.with_index do |plan, i|
      {
        provider_name: plan.provider_name,
        plan_name: plan.name,
        price: prices[i]
      }
    end
  end

  def basic_price
    plans.basic_price(contract_amp)
  end

  def energy_price
    plans.energy_price(usage)
  end
end

class Plans
  attr_reader :plans

  def initialize(plans)
    @plans = plans
  end

  # 基本料金を配列で返すようにする。例) [1000, 2000, 3000]
  def basic_price(contract_amp)
    basic_fees = []

    plans.map do |plan|
      plan.basic_charge.map do |amount|
        if amount[:ampere] == contract_amp
          basic_fee = amount[:amount]
          basic_fees << basic_fee
        end
      end
    end

    return basic_fees
  end

  def energy_price(usage)
    energy_fees = []

    plans.map do |plan|
      plan.energy_charge.map do |fee_structure|
        range = Range.new(fee_structure[:range][:from_kwh], fee_structure[:range][:to_kwh])
        if range.cover?(usage)
          energy_fee = usage * fee_structure[:cost_per_kwh]
          energy_fees << energy_fee
        end
      end
    end

    return energy_fees
  end
end

class Plan
  attr_reader :name, :provider_name, :basic_charge, :energy_charge

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
simulator = Simulator.new(40, 280, tokyo_gas, tepco, looop_denki)
simulator.simulate
