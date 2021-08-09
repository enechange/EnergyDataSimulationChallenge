require '../lib/simulator.rb'

RSpec.describe Simulator do
	describe '電気料金とプラン' do
		context "契約アンペア数が10A" do
			it '120kwまでの電気使用量' do
				simulator = Simulator.new(10, 120)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 2671},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 3168}
				)
			end
			it '300kwまでの電気使用量' do
				simulator = Simulator.new(10, 300)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 7438},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 7920}
				)
			end
			it '300kw以上の電気使用量' do
				simulator = Simulator.new(10, 400)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 10495},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 10560}
				)
			end
		end

		context "契約アンペア数が15A" do
			it '120kwまでの電気使用量' do
				simulator = Simulator.new(15, 120)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 2814},
					{:supplier=>"Looop", :plan=>"おうちプラン", :price=>3168}
				)
			end
			it '300kwまでの電気使用量' do
				simulator = Simulator.new(15, 300)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 7581},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 7920}
				)
			end
			it '300kw以上の電気使用量' do
				simulator = Simulator.new(15, 400)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 10638},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 10560}
				)
			end
		end

		context "契約アンペア数が20A" do
			it '120kwまでの電気使用量' do
				simulator = Simulator.new(20, 120)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 2957},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 3168}
				)
			end
			it '300kwまでの電気使用量' do
				simulator = Simulator.new(20, 300)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 7724},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 7920}
				)
			end
			it '300kw以上の電気使用量' do
				simulator = Simulator.new(20, 400)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 10781},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 10560}
				)
			end
		end

		context "契約アンペア数が30A" do
			it '120kwまでの電気使用量' do
				simulator = Simulator.new(30, 120)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 3243},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 3168},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 3698},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 3243}
				)
			end
			it '140kwまでの電気使用量' do
				simulator = Simulator.new(30, 140)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 3773},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 3696},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 4171},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 3773}
				)
			end
			it '300kwまでの電気使用量' do
				simulator = Simulator.new(30, 300)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 8010},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 7920},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 7992},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 8010}
				)
			end
			it '350kwまでの電気使用量' do
				simulator = Simulator.new(30, 350)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 9538},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 9240},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 9186},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 9264}
				)
			end
			it '600kwまでの電気使用量' do
				simulator = Simulator.new(30, 600)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 17181},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 15840},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 15789},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 15534}
				)
			end
			it '600kw以上の電気使用量' do
				simulator = Simulator.new(30, 700)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 20238},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 18480},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 18430},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 18149}
				)
			end
		end

		context "契約アンペア数が40A" do
			it '120kwまでの電気使用量' do
				simulator = Simulator.new(40, 120)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 3529},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 3168},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 3984},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 3529}
				)
			end
			it '140kwまでの電気使用量' do
				simulator = Simulator.new(40, 140)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 4059},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 3696},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 4457},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 4059}
				)
			end
			it '300kwまでの電気使用量' do
				simulator = Simulator.new(40, 300)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 8296},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 7920},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 8278},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 8296}
				)
			end
			it '350kwまでの電気使用量' do
				simulator = Simulator.new(40, 350)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 9824},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 9240},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 9472},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 9550}
				)
			end
			it '600kwまでの電気使用量' do
				simulator = Simulator.new(40, 600)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 17467},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 15840},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 16075},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 15820}
				)
			end
			it '600kw以上の電気使用量' do
				simulator = Simulator.new(40, 700)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 20524},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 18480},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 18716},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 18435}
				)
			end
		end

		context "契約アンペア数が50A" do
			it '120kwまでの電気使用量' do
				simulator = Simulator.new(50, 120)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 3815},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 3168},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 4270},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 3815}
				)
			end
			it '140kwまでの電気使用量' do
				simulator = Simulator.new(50, 140)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 4345},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 3696},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 4743},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 4345}
				)
			end
			it '300kwまでの電気使用量' do
				simulator = Simulator.new(50, 300)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 8582},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 7920},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 8564},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 8582}
				)
			end
			it '350kwまでの電気使用量' do
				simulator = Simulator.new(50, 350)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 10110},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 9240},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 9758},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 9836}
				)
			end
			it '600kwまでの電気使用量' do
				simulator = Simulator.new(50, 600)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 17753},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 15840},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 16361},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 16106}
				)
			end
			it '600kw以上の電気使用量' do
				simulator = Simulator.new(50, 700)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 20810},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 18480},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 19002},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 18721}
				)
			end
		end

		context "契約アンペア数が60A" do
			it '120kwまでの電気使用量' do
				simulator = Simulator.new(60, 120)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 4101},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 3168},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 4556},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 4102}
				)
			end
			it '140kwまでの電気使用量' do
				simulator = Simulator.new(60, 140)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 4631},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 3696},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 5029},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 4632}
				)
			end
			it '300kwまでの電気使用量' do
				simulator = Simulator.new(60, 300)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 8868},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 7920},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 8850},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 8868}
				)
			end
			it '350kwまでの電気使用量' do
				simulator = Simulator.new(60, 350)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 10396},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 9240},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 10044},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 10122}
				)
			end
			it '600kwまでの電気使用量' do
				simulator = Simulator.new(60, 600)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 18039},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 15840},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 16647},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 16392}
				)
			end
			it '600kw以上の電気使用量' do
				simulator = Simulator.new(60, 700)
				expect(simulator.simulate).to  contain_exactly(
					{:supplier => "東京電力", :plan => "従量電灯B", :price => 21096},
					{:supplier => "Looop", :plan => "おうちプラン", :price => 18480},
					{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 19288},
					{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 19007}
				)
			end
		end
	end
end
