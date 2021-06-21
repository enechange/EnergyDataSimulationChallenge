class Plan
  attr_reader :name, :provider_name, :basic_prices, :pay_per_use_prices

  def initialize(name:, provider_name:, basic_prices:, pay_per_use_prices:)
    @name = name
    @provider_name = provider_name
    @basic_prices = basic_prices
    @pay_per_use_prices = pay_per_use_prices
  end

  def available?(contract_amp)
    basic_prices.find { |price| price['ampere'] == contract_amp }
  end

  def plan_with_price(contract_amp, power_usage)
    {
      provider_name: provider_name,
      plan_name: name,
      price: sum_price(contract_amp, power_usage)
    }
  end

  private

  def sum_price(contract_amp, power_usage)
    (basic_price(contract_amp) + pay_per_use_price(power_usage)).floor
  end

  def basic_price(contract_amp)
    basic_prices.find { |price| price['ampere'] == contract_amp }['price']
  end

  def pay_per_use_price(power_usage)
    sum = 0
    power_usage_before_stage = 0
    sorted_pay_per_use_price_lists(power_usage).each do |price_list|
      power_usage_current_stage = power_usage - price_list['min_kwh'] - power_usage_before_stage
      #丸め誤差が生じるため小数点第四位を四捨五入とする
      sum += (price_list['price_per_kwh'] * power_usage_current_stage).round(3)
      power_usage_before_stage += power_usage_current_stage
    end
    sum
  end

  def sorted_pay_per_use_price_lists(power_usage)
    pay_per_use_price_lists(power_usage).sort_by {|list| list['min_kwh']}.reverse
  end

  def pay_per_use_price_lists(power_usage)
    pay_per_use_prices.select { |price| price['min_kwh'] <= power_usage }
  end
end
