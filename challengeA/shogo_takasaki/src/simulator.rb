# frozen_string_literal: true

require 'json'

# Simulator for electric usage
class Simulator
  attr_accessor :ampere, :usage, :plans

  def initialize(ampere, usage)
    @ampere = ampere
    @usage = usage
    File.open("plans.json") do |f|
      @plans = JSON.load(f)
    end
  end

  def simulate
    @plans['suppliers'].map do |plan|
      {
        provider_name: plan['provider_name'],
        plan_name: plan['plan_name'],
        price: plan.price(@ampere, @usage)
      }
    end
  end
end
