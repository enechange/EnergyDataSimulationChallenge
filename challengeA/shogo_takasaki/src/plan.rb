# frozen_string_literal: true

# display plan info
class Plan
  attr_reader :provider_name, :plan_name, :basic_price_list, :additional_price_list

  module Message
    NO_BASIC_PRICE = '基本料金設定無し'
    NO_UNIT_PRICE = '従量料金設定無し'
  end

  def initialize(plan)
    @provider_name = plan['provider_name']
    @plan_name = plan['plan_name']
    @basic_price_list = plan['basic_price']
    @additional_price_list = plan['additional_price']
  end

  def basic_price(ampere, usage)
    return @basic_price_list[ampere.to_s] / 2 if usage.zero?

    @basic_price_list[ampere.to_s] or raise Message::NO_BASIC_PRICE
  end

  def unit_price(usage)
    @additional_price_list.each do |_price|
      return _price[1] if usage <= _price[0].to_i
    end
    raise Message::NO_UNIT_PRICE
  end

  def additional_price(usage)
    unit_price(usage) * usage
  end

  def price(ampere, usage)
    basic_price(ampere, usage) + additional_price(usage)
  end

  def price_with_tax(ampere, usage)
    # 有効桁数は単価表に合わせ、小数点以下2桁とする
    price(ampere, usage) + (price(ampere, usage) * Simulator::TAX_RATE).round(2)
  end

  def display(ampere, usage)
    {
      provider_name: provider_name,
      plan_name: plan_name,
      price: price_with_tax(ampere, usage)
    }
  end
end
