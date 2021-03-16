RSpec.describe Simulator do
  describe '東京電力エナジーパートナー従量電灯B' do
    before do
      tepco = Plan::ALLPLANS.find { |n| n.provider_name == '東京電力エナジーパートナー' }
      @basic_charge_list = tepco.basic_charge_list.to_a
      @usage_unit_charge_list = tepco.usage_charge_list.to_a
      @min_charge = tepco.min_charge
    end

    context '10A' do
      it '0kWh' do
        simulator = Simulator.new(10, 0)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 231
      end

      it '1kWh' do
        simulator = Simulator.new(10, 1)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 305
      end

      it '60kWh' do
        simulator = Simulator.new(10, 60)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 1478
      end

      it '120kWh' do
        simulator = Simulator.new(10, 120)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 2671
      end

      it '121kWh' do
        simulator = Simulator.new(10, 121)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 2698
      end

      it '210kWh' do
        simulator = Simulator.new(10, 210)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 5054
      end

      it '300kWh' do
        simulator = Simulator.new(10, 300)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 7438
      end

      it '301kWh' do
        simulator = Simulator.new(10, 301)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 7468
      end

      it '999999kWh' do
        simulator = Simulator.new(10, 999_999)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 30_568_236
      end

      it '110.46kWh *使用量の四捨五入処理が正しいか' do
        simulator = Simulator.new(10, 110.46)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 2472
      end

      it '198.65kWh *使用量の四捨五入処理が正しいか' do
        simulator = Simulator.new(10, 198.65)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 4763
      end
    end

    context '15A' do
      it '0kWh' do
        simulator = Simulator.new(15, 0)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 231
      end

      it '1kWh' do
        simulator = Simulator.new(15, 1)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 448
      end

      it '60kWh' do
        simulator = Simulator.new(15, 60)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 1621
      end

      it '120kWh' do
        simulator = Simulator.new(15, 120)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 2814
      end

      it '121kWh' do
        simulator = Simulator.new(15, 121)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 2841
      end

      it '210kWh' do
        simulator = Simulator.new(15, 210)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 5197
      end

      it '300kWh' do
        simulator = Simulator.new(15, 300)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 7581
      end

      it '301kWh' do
        simulator = Simulator.new(15, 301)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 7611
      end

      it '999999kWh' do
        simulator = Simulator.new(15, 999_999)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 30_568_379
      end
    end

    context '20A' do
      it '0kWh' do
        simulator = Simulator.new(20, 0)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 286
      end

      it '1kWh' do
        simulator = Simulator.new(20, 1)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 591
      end

      it '60kWh' do
        simulator = Simulator.new(20, 60)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 1764
      end

      it '120kWh' do
        simulator = Simulator.new(20, 120)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 2957
      end

      it '121kWh' do
        simulator = Simulator.new(20, 121)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 2984
      end

      it '210kWh' do
        simulator = Simulator.new(20, 210)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 5340
      end

      it '300kWh' do
        simulator = Simulator.new(20, 300)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 7724
      end

      it '301kWh' do
        simulator = Simulator.new(20, 301)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 7754
      end

      it '999999kWh' do
        simulator = Simulator.new(20, 999_999)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 30_568_522
      end
    end

    context '30A' do
      it '0kWh' do
        simulator = Simulator.new(30, 0)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 429
      end

      it '1kWh' do
        simulator = Simulator.new(30, 1)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 877
      end

      it '60kWh' do
        simulator = Simulator.new(30, 60)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 2050
      end

      it '120kWh' do
        simulator = Simulator.new(30, 120)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 3243
      end

      it '121kWh' do
        simulator = Simulator.new(30, 121)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 3270
      end

      it '210kWh' do
        simulator = Simulator.new(30, 210)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 5626
      end

      it '300kWh' do
        simulator = Simulator.new(30, 300)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 8010
      end

      it '301kWh' do
        simulator = Simulator.new(30, 301)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 8040
      end

      it '999999kWh' do
        simulator = Simulator.new(30, 999_999)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 30_568_808
      end
    end

    context '40A' do
      it '0kWh' do
        simulator = Simulator.new(40, 0)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 572
      end

      it '1kWh' do
        simulator = Simulator.new(40, 1)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 1163
      end

      it '60kWh' do
        simulator = Simulator.new(40, 60)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 2336
      end

      it '120kWh' do
        simulator = Simulator.new(40, 120)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 3529
      end

      it '121kWh' do
        simulator = Simulator.new(40, 121)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 3556
      end

      it '210kWh' do
        simulator = Simulator.new(40, 210)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 5912
      end

      it '300kWh' do
        simulator = Simulator.new(40, 300)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 8296
      end

      it '301kWh' do
        simulator = Simulator.new(40, 301)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 8326
      end

      it '999999kWh' do
        simulator = Simulator.new(40, 999_999)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 30_569_094
      end
    end

    context '50A' do
      it '0kWh' do
        simulator = Simulator.new(50, 0)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 715
      end

      it '1kWh' do
        simulator = Simulator.new(50, 1)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 1449
      end

      it '60kWh' do
        simulator = Simulator.new(50, 60)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 2622
      end

      it '120kWh' do
        simulator = Simulator.new(50, 120)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 3815
      end

      it '121kWh' do
        simulator = Simulator.new(50, 121)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 3842
      end

      it '210kWh' do
        simulator = Simulator.new(50, 210)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 6198
      end

      it '300kWh' do
        simulator = Simulator.new(50, 300)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 8582
      end

      it '301kWh' do
        simulator = Simulator.new(50, 301)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 8612
      end

      it '999999kWh' do
        simulator = Simulator.new(50, 999_999)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 30_569_380
      end
    end

    context '60A' do
      it '0kWh' do
        simulator = Simulator.new(60, 0)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 858
      end

      it '1kWh' do
        simulator = Simulator.new(60, 1)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 1735
      end

      it '60kWh' do
        simulator = Simulator.new(60, 60)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 2908
      end

      it '120kWh' do
        simulator = Simulator.new(60, 120)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 4101
      end

      it '121kWh' do
        simulator = Simulator.new(60, 121)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 4128
      end

      it '210kWh' do
        simulator = Simulator.new(60, 210)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 6484
      end

      it '300kWh' do
        simulator = Simulator.new(60, 300)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 8868
      end

      it '301kWh' do
        simulator = Simulator.new(60, 301)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 8898
      end

      it '999999kWh' do
        simulator = Simulator.new(60, 999_999)
        expect(simulator.calculate(@basic_charge_list, @usage_unit_charge_list, @min_charge)).to eq 30_569_666
      end
    end
  end
end
