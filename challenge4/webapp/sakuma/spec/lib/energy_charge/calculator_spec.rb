require 'rails_helper'

RSpec.describe EnergyCharge::Calculator, type: :lib do

  let(:only_day_time_plan) do
    Plan.new(
      name: "Day time only Plan",
      day_time: [ [ nil, 120, 19.43], [ 120, 300, 25.91], [ 300, nil, 29.93] ],
      night_time: nil,
      night_time_range: nil,
    )
  end

  describe '.new' do
    let(:calculator) { EnergyCharge::Calculator.new(plan: only_day_time_plan, consumptions: []) }
    it { expect(calculator).to be }
  end

  describe '#calc' do
  end

  describe '#calc_day_time (private)' do
  end

  describe '#calc_night_time (private)' do
  end
end
