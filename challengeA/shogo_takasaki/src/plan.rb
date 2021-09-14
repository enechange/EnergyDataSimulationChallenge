# frozen_string_literal: true

# display plan info
class Plan
  attr_accessor :provider_name, :plan_name, :basic_price, :additional_price

  def initialize(provider_name: '', plan_name: '', basic_price: {}, additional_price: {})
    @provider_name = provider_name
    @plan_name = plan_name
    @basic_price = basic_price
    @additional_price = additional_price
  end

  def price(ampere: 0, usage: 0)
    @basic_price.first.to_i + @additional_price.first.to_i
  end

  def get_basic_price(ampere: 0)
    0
  end

  def get_additional_price(usage: 0)
    0
  end
end
