# frozen_string_literal: true

require 'json'

# Simulator for electric usage
class Simulator
  attr_reader :ampere, :usage, :plans

  TAX_RATE = 0.1

  def initialize(ampere, usage)
    @ampere = ampere
    @usage = usage
    File.open('../data/plans.json') do |f|
      @plans = JSON.load(f)
    end
  end

  def simulate
    @plans['suppliers'].map do |plan|
      Plan.new(plan).display(@ampere, @usage)
    end
  end
end
