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
  let(:night_plan) do
    Plan.new(
      name: "Yoru Toku Plan",
      day_time: [ [ nil, 90, 24.03], [ 90, 230, 32.03], [ 230, nil, 37.00] ],
      night_time: [ nil, nil, 12.48] ,
      night_time_range: [
        true, true, true, true, true, false, false, false, false,
        false, false, false, false, false, false, false, false,
        false, false, false, false, true, true, true
      ]
    )
  end
  let(:calculator) { EnergyCharge::Calculator.new(plan: plan, consumptions: [[]]) }

  describe '#calc' do
  end

  describe '#calc_day_time (private)' do
  end

  describe '#calc_night_time (private)' do

    subject { calculator.send(:calc_night_time, consumption) }

    context 'about night time plan' do
      let(:plan) { night_plan }
      let(:consumption) { 20.001324 }

      it { is_expected.to eq ( 249.61652352 )}  # 20.001324 * 12.48
    end

    context 'about day time only plan' do
      let(:plan) { only_day_time_plan }
      let(:consumption) { 19.001324 }

      it { is_expected.to eq 0 }
    end
  end
end
