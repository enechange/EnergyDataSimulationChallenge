# frozen_string_literal: true

# display plan info
class Plan
  attr_reader :provider_name, :plan_name, :basic_price_list, :usage_price_list

  module Message
    NO_BASIC_PRICE = '基本料金設定無し'
    NO_UNIT_PRICE = '従量料金設定無し'
  end

  def initialize(plan)
    @provider_name = plan['provider_name']
    @plan_name = plan['plan_name']
    @basic_price_list = plan['basic_price']
    @usage_price_list = plan['usage_price']
  end

  def basic_price(ampere, usage)
    raise Message::NO_BASIC_PRICE if @basic_price_list[ampere.to_s].nil?
    return @basic_price_list[ampere.to_s] / 2 if usage.zero?

    @basic_price_list[ampere.to_s]
  end

  def unit_price(usage)
    result = @usage_price_list.select { |k, v| k.to_i <= usage }.max.last
    return result unless result.nil?

    raise Message::NO_UNIT_PRICE
  end

  def usage_price(usage)
    unit_price(usage) * usage
  end

  def price(ampere, usage)
    basic_price(ampere, usage) + usage_price(usage)
  end

  def price_with_tax(ampere, usage)
    (price(ampere, usage) + (price(ampere, usage) * Simulator::TAX_RATE)).to_i
  end

  def display(ampere, usage)
    {
      provider_name: provider_name,
      plan_name: plan_name,
      price: price_with_tax(ampere, usage)
    }
  end
end
