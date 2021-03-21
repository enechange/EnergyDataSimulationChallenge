require_relative '../lib/simulator.rb'

RSpec.describe Simulator do
  describe "プラン名と料金を含む配列数と段階別の計算結果" do
    context "10Aの場合" do
      it "10A/120kWhの場合、配列数2つ" do
        simulator = Simulator.new(10, 120)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"2671"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3168"}
        )
      end
      it "10A/140kWhの場合、配列数2つ" do
        simulator = Simulator.new(10, 140)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"3201"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3696"}
        )
      end
      it "10A/300kWhの場合、配列数2つ" do
        simulator = Simulator.new(10, 300)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"7438"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"7920"}
        )
      end
      it "10A/350kWhの場合、配列数2つ" do
        simulator = Simulator.new(10, 350)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"8966"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"9240"}
        )
      end
      it "10A/400kWhの場合、配列数2つ" do
        simulator = Simulator.new(10, 400)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"10495"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"10560"}
        )
      end
    end

    context "30Aの場合" do
      it "30A/120kWhの場合、配列数3つ" do
        simulator = Simulator.new(30, 120)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"3243"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3168"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"3698"}
        )
      end
      it "30A/140kWhの場合、配列数3つ" do
        simulator = Simulator.new(30, 140)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"3773"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3696"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"4171"}
        )
      end
      it "30A/300kWhの場合、配列数3つ" do
        simulator = Simulator.new(30, 300)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"8010"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"7920"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"7992"}
        )
      end
      it "30A/350kWhの場合、配列数3つ" do
        simulator = Simulator.new(30, 350)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"9538"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"9240"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"9186"}
        )
      end
      it "30A/400kWhの場合、配列数3つ" do
        simulator = Simulator.new(30, 400)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"11067"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"10560"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"10507"}
        )
      end
    end

    context "40Aの場合" do
      it "40A/120kWhの場合、配列数3つ" do
        simulator = Simulator.new(40, 120)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"3529"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3168"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"3984"}
        )
      end
      it "40A/140kWhの場合、配列数3つ" do
        simulator = Simulator.new(40, 140)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"4059"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3696"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"4457"}
        )
      end
      it "40A/300kWhの場合、配列数3つ" do
        simulator = Simulator.new(40, 300)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"8296"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"7920"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"8278"}
        )
      end
      it "40A/350kWhの場合、配列数3つ" do
        simulator = Simulator.new(40, 350)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"9824"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"9240"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"9472"}
        )
      end
      it "40A/400kWhの場合、配列数3つ" do
        simulator = Simulator.new(40, 400)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"11353"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"10560"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"10793"}
        )
      end
    end
  end
end