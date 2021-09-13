# frozen_string_literal: true

# Simulator for electric usage
class Simulator
  attr_accessor :ampere, :usage

  def initialize(ampere, usage)
    @ampere = ampere
    @usage = usage
  end

  def simulate
    [
      { provider_name: 'Looopでんき', plan_name: 'おうちプラン', price: '1234' },
      { provider_name: 'Looopでんき2', plan_name: 'おうちプラン4', price: '12345' },
      { provider_name: 'Looopでんき3', plan_name: 'おうちプラン5', price: '12346' }
    ]
  end
end
