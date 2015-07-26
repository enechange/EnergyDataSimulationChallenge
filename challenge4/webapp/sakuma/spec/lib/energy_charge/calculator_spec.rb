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
  let(:calculator) { EnergyCharge::Calculator.new(plan: plan, consumptions: consumptions) }

  describe '#calc' do
    let(:consumptions) { YAML.load_file(Rails.root.join('spec/support/sample_consumptions', '127.yml')) }
    subject { calculator.calc }
    context 'about day time only plan' do
      let(:plan) { only_day_time_plan }

      it { is_expected.to eq 2532 }
    end

    context 'about night time plan' do
      let(:plan) { night_plan }

      it { is_expected.to eq 2620 }
    end
  end

  describe '#calc_day_time (private)' do
    let(:consumptions) { [] }

    subject { calculator.send(:calc_day_time, consumption) }

    context 'about day time only plan' do
      let(:plan) { only_day_time_plan }

      context 'The 1st stage rate' do

        context 'less than 120 kWh' do
          let(:consumption) { 98.101544 }
          it { is_expected.to eq 1906.11299992 }  # 98.101544 * 19.43
        end
        context 'equal the initial 120 kWh' do
          let(:consumption) { 120.0 }
          it { is_expected.to eq 2331.6 }  # 120.0 * 19.43
        end
      end

      context 'The 2nd stage rate' do

        context 'slightly larger than 120kWh ' do
          let(:consumption) { 120.0000001 }
          # (120.0 * 19.43) + (0.0000001 * 25.91)
          it { is_expected.to eq 2331.600002591 }
        end
        context 'larger than 120kWh up to 300kWh' do
          let(:consumption) { 223.2342032932 }
          # (120.0 * 19.43) + (103.2342032932 * 25.91)
          it { is_expected.to eq 5006.398207326812 }
        end
        context 'equal 300kWh' do
          let(:consumption) { 300.0 }
          it { is_expected.to eq 6995.4 } # (120.0 * 19.43) + (180.0 * 25.91)
        end
      end

      context 'The 3rd stage rate' do

        context 'slightly larger than 300kWh' do
          let(:consumption) { 300.0000001 }
          # (120.0 * 19.43) + (180.0 * 25.91) + (0.0000001 * 29.93)
          it { is_expected.to eq 6995.400002993 }
        end
        context 'larger than 300kWh' do
          let(:consumption) { 321.1324093 }
          # (120.0 * 19.43) + (180.0 * 25.91) + (21.1324093 * 29.93)
          it { is_expected.to eq 7627.893010349 }
        end
      end
    end

    context 'about night time plan' do

      let(:plan) { night_plan }

      context 'The 1st stage rate' do

        context 'less than 90 kWh' do
          let(:consumption) { 63.2329280 }
          it { is_expected.to eq 1519.48725984 }  # 63.2329280 * 24.03
        end
        context 'equal the initial 90 kWh' do
          let(:consumption) { 90.0 }
          it { is_expected.to eq 2162.7 }  # 90.0 * 24.03
        end
      end

      context 'The 2nd stage rate' do

        context 'slightly larger than 90 kWh ' do
          let(:consumption) { 90.0000001 }
          # (90.0 * 24.03) + (0.0000001 * 32.03)
          it { is_expected.to eq 2162.700003203 }
        end
        context 'larger than 90 kWh up to 230 kWh' do
          let(:consumption) { 123.2342032932 }
          # (90.0 * 24.03) + (33.2342032932 * 32.03)
          it { is_expected.to eq 3227.191531481196 }
        end
        context 'equal 230 kWh' do
          let(:consumption) { 230.0 }
          it { is_expected.to eq 6646.9 } # (90.0 * 24.03) + (140.0 * 32.03)
        end
      end

      context 'The 3rd stage rate' do

        context 'slightly larger than 230 kWh' do
          let(:consumption) { 230.0000001 }
          # (90.0 * 24.03) + (140.0 * 32.03) + (0.0000001 * 37.00)
          it { is_expected.to eq 6646.9000037 }
        end
        context 'larger than 230 kWh' do
          let(:consumption) { 309.932342 }
          # (120.0 * 19.43) + (180.0 * 25.91) + (79.932342 * 29.93)
          it { is_expected.to eq 9604.39665400000037 }
        end
      end
    end

  end

  describe '#calc_night_time (private)' do
    let(:consumptions) { [] }

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
