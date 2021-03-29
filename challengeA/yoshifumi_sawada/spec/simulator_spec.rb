require_relative '../lib/simulator.rb'

RSpec.describe Simulator do
  describe "プラン名と料金を含む配列数と段階別の計算結果" do
    context "20Aの場合" do
      it "20A/120kWhの場合、配列数2つ" do
        simulator = Simulator.new(20, 120)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"2957"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3168"}
        )
      end
      it "20A/121kWhの場合、配列数2つ" do
        simulator = Simulator.new(20, 121)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"2984"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3194"}
        )
      end
      it "20A/300kWhの場合、配列数2つ" do
        simulator = Simulator.new(20, 300)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"7724"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"7920"}
        )
      end
      it "20A/301kWhの場合、配列数2つ" do
        simulator = Simulator.new(20, 301)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"7754"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"7946"}
        )
      end
    end

    context "30Aの場合" do
      it "30A/140kWhの場合、配列数4つ" do
        simulator = Simulator.new(30, 140)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"3773"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3696"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"4171"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"3773"}
        )
      end
      it "30A/141kWhの場合、配列数4つ" do
        simulator = Simulator.new(30, 141)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"3799"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3722"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"4195"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"3799"}
        )
      end
      it "30A/300kWhの場合、配列数4つ" do
        simulator = Simulator.new(30, 300)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"8010"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"7920"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"7992"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"8010"}
        )
      end
      it "30A/301kWhの場合、配列数4つ" do
        simulator = Simulator.new(30, 301)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"8040"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"7946"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"8016"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"8035"}
        )
      end
      it "30A/350kWhの場合、配列数4つ" do
        simulator = Simulator.new(30, 350)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"9538"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"9240"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"9186"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"9264"}
        )
      end
      it "30A/351kWhの場合、配列数4つ" do
        simulator = Simulator.new(30, 351)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"9569"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"9266"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"9213"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"9289"}
        )
      end
      it "30A/600kWhの場合、配列数4つ" do
        simulator = Simulator.new(30, 600)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"17181"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"15840"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"15789"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"15534"}
        )
      end
      it "30A/601kWhの場合、配列数4つ" do
        simulator = Simulator.new(30, 601)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"17211"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"15866"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"15815"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"15560"}
        )
      end
    end

    context "40Aの場合" do
      it "40A/140kWhの場合、配列数4つ" do
        simulator = Simulator.new(40, 140)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"4059"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3696"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"4457"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"4059"}
        )
      end
      it "40A/141kWhの場合、配列数4つ" do
        simulator = Simulator.new(40, 141)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"4085"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"3722"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"4481"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"4085"}
        )
      end
      it "40A/300kWhの場合、配列数4つ" do
        simulator = Simulator.new(40, 300)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"8296"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"7920"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"8278"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"8296"}
        )
      end
      it "40A/301kWhの場合、配列数4つ" do
        simulator = Simulator.new(40, 301)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"8326"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"7946"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"8302"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"8321"}
        )
      end
      it "40A/350kWhの場合、配列数4つ" do
        simulator = Simulator.new(40, 350)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"9824"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"9240"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"9472"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"9550"}
        )
      end
      it "40A/351kWhの場合、配列数4つ" do
        simulator = Simulator.new(40, 351)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"9855"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"9266"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"9499"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"9575"}
        )
      end
      it "40A/600kWhの場合、配列数4つ" do
        simulator = Simulator.new(40, 600)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"17467"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"15840"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"16075"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"15820"}
        )
      end
      it "40A/601kWhの場合、配列数4つ" do
        simulator = Simulator.new(40, 601)
        expect(simulator.simulate).to contain_exactly(
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>"17497"},
          {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>"15866"},
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>"16101"},
          {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>"15846"}
        )
      end
    end
  end
end