# frozen_string_literal: true

# display plan info
class Plan
  attr_reader :provider_name, :plan_name, :basic_price, :additional_price

  module Message
    NO_BASIC_PRICE = '基本料金設定無し'
    NO_UNIT_PRICE = '従量料金設定無し'
  end

  def initialize(plan)
    @provider_name = plan['provider_name']
    @plan_name = plan['plan_name']
    @basic_price = plan['basic_price']
    @additional_price = plan['additional_price']
  end

  def price(ampere, usage)
    basic_price(ampere) + additional_price(usage)
  end

  def basic_price(ampere)
    @basic_price[ampere.to_s] || Message::NO_BASIC_PRICE
  end

  def additional_price(usage)
    unit_price(usage) * usage
  end

  def unit_price(usage)
    @additional_price.each do |_price|
      return _price[1] if usage <= _price[0].to_i
    end
    Message::NO_UNIT_PRICE
  end

  def display(ampere, usage)
    {
      provider_name: provider_name,
      plan_name: plan_name,
      price: price(ampere, usage)
    }
  end
end
