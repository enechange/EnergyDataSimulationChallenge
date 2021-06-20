class Simulator
  attr_reader :contract_amp, :power_usage, :plans

  def initialize(contract_amp, power_usage)
    @contract_amp = contract_amp
    @power_usage = power_usage
    @plans = Plan.new(contract_amp, power_usage)
  end

  def simulate
    plans.show_plans
  end
end

class Plan
  attr_reader :contract_amp, :power_usage, :plans

  def initialize(contract_amp, power_usage)
    @plans = plans
    @contract_amp = contract_amp
    @power_usage = power_usage
  end

  def show_plans
    plans.map { |plan| available?(plan)? plan_with_price(plan) : nil }.compact
  end

  private

  def available?(plan)
    plan[:basic_price].find { |price| price[:ampere] == contract_amp }
  end

  def plan_with_price(plan)
    {
      provider_name: plan[:provider_name],
      plan_name: plan[:name],
      price: sum_price(plan)
    }
  end

  def sum_price(plan)
    (basic_price(plan) + pay_per_use_price(plan)).floor
  end

  def basic_price(plan)
    plan[:basic_price].find { |price| price[:ampere] == contract_amp }[:price]
  end

  def pay_per_use_price(plan)
    sum = 0
    power_usage_before_stage = 0
    sorted_pay_per_use_price_lists(plan).each do |price_list|
      power_usage_current_stage = power_usage - price_list[:min_kwh] - power_usage_before_stage
      #丸め誤差が生じるため小数点第四位を四捨五入とする
      sum += (price_list[:price_per_kwh] * power_usage_current_stage).round(3)
      power_usage_before_stage += power_usage_current_stage
    end
    sum
  end

  def sorted_pay_per_use_price_lists(plan)
    pay_per_use_price_lists(plan).sort_by {|list| list[:min_kwh]}.reverse
  end

  def pay_per_use_price_lists(plan)
    plan[:pay_per_use_price].select { |price| price[:min_kwh] <= power_usage }
  end

  def plans
    [
      {
        name: '従量電灯B',
        provider_name: '東京電力エナジーパートナー',
        basic_price: [
          {
            "ampere": 10,
            "price": 286.0
          },
          {
            "ampere": 15,
            "price": 429.0
          },
          {
            "ampere": 20,
            "price": 572.0
          },
          {
            "ampere": 30,
            "price": 858.0
          },
          {
            "ampere": 40,
            "price": 1144.0
          },
          {
            "ampere": 50,
            "price": 1430.0
          },
          {
            "ampere": 60,
            "price": 1716.0
          }
        ],
        pay_per_use_price: [
          {
            "price_per_kwh": 19.88,
            "min_kwh": 0
          },
          {
            "price_per_kwh": 26.48,
            "min_kwh": 120
          },
          {
            "price_per_kwh": 30.57,
            "min_kwh": 300
          }
        ]
      },
      {
        name: 'おうちプラン',
        provider_name: 'Looopでんき',
        basic_price: [
          {
            "ampere": 10,
            "price": 0
          },
          {
            "ampere": 15,
            "price": 0
          },
          {
            "ampere": 20,
            "price": 0
          },
          {
            "ampere": 30,
            "price": 0
          },
          {
            "ampere": 40,
            "price": 0
          },
          {
            "ampere": 50,
            "price": 0
          },
          {
            "ampere": 60,
            "price": 0
          }
        ],
        pay_per_use_price: [
          {
            "price_per_kwh": 26.40,
            "min_kwh": 0
          }
        ]
      },
      {
        name: 'ずっとも電気１',
        provider_name: '東京ガス',
        basic_price: [
          {
            "ampere": 30,
            "price": 858.0
          },
          {
            "ampere": 40,
            "price": 1144.0
          },
          {
            "ampere": 50,
            "price": 1430.0
          },
          {
            "ampere": 60,
            "price": 1716.0
          }
        ],
        pay_per_use_price: [
          {
            "price_per_kwh": 23.67,
            "min_kwh": 0
          },
          {
            "price_per_kwh": 23.88,
            "min_kwh": 140
          },
          {
            "price_per_kwh": 26.41,
            "min_kwh": 350
          }
        ]
      },
      {
        name: '従量電灯Bたっぷりプラン',
        provider_name: 'JXTGでんき',
        basic_price: [
          {
            "ampere": 30,
            "price": 858.0
          },
          {
            "ampere": 40,
            "price": 1144.0
          },
          {
            "ampere": 50,
            "price": 1430.0
          },
          {
            "ampere": 60,
            "price": 1716.8
          }
        ],
        pay_per_use_price: [
          {
            "price_per_kwh": 19.88,
            "min_kwh": 0
          },
          {
            "price_per_kwh": 26.48,
            "min_kwh": 120
          },
          {
            "price_per_kwh": 25.08,
            "min_kwh": 300
          },
          {
            "price_per_kwh": 26.15,
            "min_kwh": 600
          }
        ]
      }
    ]
  end
end

simulator = Simulator.new(30,600)
puts simulator.simulate
