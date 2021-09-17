# frozen_string_literal: true

require 'json'

# Simulator for electric usage
class Simulator
  attr_accessor :ampere, :usage, :plans

  TAX_RATE = 0.1

  def initialize(ampere, usage)
    @ampere = ampere
    @usage = usage
    File.open("../data/plans.json") do |f|
      @plans = JSON.load(f)
    end
  end

  def simulate
    @plans['suppliers'].map do |_plan|
      Plan.new(
        _plan['provider_name'], _plan['plan_name'], _plan['basic_price'], _plan['additional_price']
      ).display(@ampere, @usage)
    end
  end
end
