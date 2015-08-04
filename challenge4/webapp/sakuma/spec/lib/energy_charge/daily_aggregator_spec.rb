require 'rails_helper'

RSpec.describe EnergyCharge::DailyAggregator, type: :lib do

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

  describe '#aggregate' do
    let(:sample_daily_consumption) { [0.101] * 24 }
    let(:daily_session) do
      EnergyCharge::DailyAggregator.new(
        plan: target_plan, daily_cons: sample_daily_consumption
      )
    end

    context 'when day time only plan' do
      let(:target_plan) { only_day_time_plan }
      subject { daily_session.aggregate }
      it { is_expected.to eq [BigDecimal("2.424"), BigDecimal("0.0")] }
    end

    context 'when yoru toku plan' do
      let(:target_plan) { night_plan }
      subject { daily_session.aggregate }
      it { is_expected.to eq [BigDecimal("1.616"), BigDecimal("0.808")] }
    end
  end

end
