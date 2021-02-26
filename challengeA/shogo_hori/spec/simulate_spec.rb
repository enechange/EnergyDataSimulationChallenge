RSpec.describe Simulator do
  describe '料金計算シュミレーション機能' do
    context '有効なシュミレーション' do
      it '10A、100kWh' do
        simulator = Simulator.new(10, 100)
        expect(simulator.simulate).to match_array(
          [{ :provider_name=>'東京電力エナジーパートナー', :plan_name=>'従量電灯B', :price=>'2274' },
           {:provider_name=>'Looopでんき', :plan_name=>'おうちでんきプラン', :price=>'2640' }]
        )
      end

      it '30A、200kWh' do
        simulator = Simulator.new(30, 200)
        expect(simulator.simulate).to match_array(
          [{ :provider_name=>'東京電力エナジーパートナー', :plan_name=>'従量電灯B', :price=>'6154' },
           {:provider_name=>'Looopでんき', :plan_name=>'おうちでんきプラン', :price=>'5280' },
           {:provider_name=>'東京ガス', :plan_name=>'ずっとも電気１', :price=>'5634' }]
        )
      end
    end

    context '無効なシュミレーション' do
      it 'A、kWh共に英字' do
        expect(Simulator.new('a', 'b')).to include "アンペアは10, 15, 20, 30, 40, 50, 60中から入力ください。\n使用量は0以上の数値で入力ください。"
      end
    end
  end
end
