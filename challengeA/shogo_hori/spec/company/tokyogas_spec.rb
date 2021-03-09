RSpec.describe Simulator do
  describe '東京ガスずっとも電気１' do
    before do
      tokyogas = Plan::ALLPLANS.find { |n| n.provider_name == '東京ガス' }
      @basic_charge_list = tokyogas.basic_charge_list.to_a
      @usage_unit_charge_list = tokyogas.usage_charge_list.to_a
      @min_charge = tokyogas.min_charge
    end

    context '30A' do
      it '0kWh' do
        simulator = Simulator.new(30, 0)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 429
      end

      it '1kWh' do
        simulator = Simulator.new(30, 1)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 881
      end

      it '70kWh' do
        simulator = Simulator.new(30, 70)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 2514
      end

      it '140kWh' do
        simulator = Simulator.new(30, 140)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 4171
      end

      it '141kWh' do
        simulator = Simulator.new(30, 141)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 4195
      end

      it '245kWh' do
        simulator = Simulator.new(30, 245)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 6679
      end

      it '350kWh' do
        simulator = Simulator.new(30, 350)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 9186
      end

      it '351kWh' do
        simulator = Simulator.new(30, 351)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 9213
      end

      it '999999kWh' do
        simulator = Simulator.new(30, 999_999)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 26_409_916
      end

      it '110.46kWh *使用量の四捨五入処理が正しいか' do
        simulator = Simulator.new(30, 110.46)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 3461
      end

      it '198.65kWh *使用量の四捨五入処理が正しいか' do
        simulator = Simulator.new(30, 198.65)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 5580
      end
    end

    context '40A' do
      it '0kWh' do
        simulator = Simulator.new(40, 0)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 572
      end

      it '1kWh' do
        simulator = Simulator.new(40, 1)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 1167
      end

      it '70kWh' do
        simulator = Simulator.new(40, 70)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 2800
      end

      it '140kWh' do
        simulator = Simulator.new(40, 140)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 4457
      end

      it '141kWh' do
        simulator = Simulator.new(40, 141)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 4481
      end

      it '245kWh' do
        simulator = Simulator.new(40, 245)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 6965
      end

      it '350kWh' do
        simulator = Simulator.new(40, 350)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 9472
      end

      it '351kWh' do
        simulator = Simulator.new(40, 351)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 9499
      end

      it '999999kWh' do
        simulator = Simulator.new(40, 999_999)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 26_410_202
      end
    end

    context '50A' do
      it '0kWh' do
        simulator = Simulator.new(50, 0)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 715
      end

      it '1kWh' do
        simulator = Simulator.new(50, 1)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 1453
      end

      it '70kWh' do
        simulator = Simulator.new(50, 70)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 3086
      end

      it '140kWh' do
        simulator = Simulator.new(50, 140)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 4743
      end

      it '141kWh' do
        simulator = Simulator.new(50, 141)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 4767
      end

      it '245kWh' do
        simulator = Simulator.new(50, 245)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 7251
      end

      it '350kWh' do
        simulator = Simulator.new(50, 350)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 9758
      end

      it '351kWh' do
        simulator = Simulator.new(50, 351)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 9785
      end

      it '999999kWh' do
        simulator = Simulator.new(50, 999_999)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 26_410_488
      end
    end

    context '60A' do
      it '0kWh' do
        simulator = Simulator.new(60, 0)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 858
      end

      it '1kWh' do
        simulator = Simulator.new(60, 1)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 1739
      end

      it '70kWh' do
        simulator = Simulator.new(60, 70)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 3372
      end

      it '140kWh' do
        simulator = Simulator.new(60, 140)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 5029
      end

      it '141kWh' do
        simulator = Simulator.new(60, 141)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 5053
      end

      it '245kWh' do
        simulator = Simulator.new(60, 245)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 7537
      end

      it '350kWh' do
        simulator = Simulator.new(60, 350)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 10_044
      end

      it '351kWh' do
        simulator = Simulator.new(60, 351)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 10_071
      end

      it '999999kWh' do
        simulator = Simulator.new(60, 999_999)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 26_410_774
      end
    end
  end
end
