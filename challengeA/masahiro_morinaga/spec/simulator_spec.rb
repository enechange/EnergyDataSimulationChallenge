require '../lib/simulator.rb'

RSpec.describe Simulator do
	describe '電気料金とプラン' do
		context "契約アンペア数が10A" do
			it '120kwまでの電気使用量' do
				simulator = Simulator.new(10, 120)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 2671.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 3168.0}]
				)
			end
			it '300kwまでの電気使用量' do
				simulator = Simulator.new(10, 300)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 8230.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 7920.0}]
				)
			end
			it '300kw以上の電気使用量' do
				simulator = Simulator.new(10, 400)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 12514.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 10560.0}]
				)
			end
		end

		context "契約アンペア数が15A" do
			it '120kwまでの電気使用量' do
				simulator = Simulator.new(15, 120)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 2814.0}],
					[{:supplier=>"Looop", :plan=>"おうちプラン", :price=>3168.0}]
				)
			end
			it '300kwまでの電気使用量' do
				simulator = Simulator.new(15, 300)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 8373.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 7920.0}]
				)
			end
			it '300kw以上の電気使用量' do
				simulator = Simulator.new(15, 400)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 12657.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 10560.0}]
				)
			end
		end

		context "契約アンペア数が20A" do
			it '120kwまでの電気使用量' do
				simulator = Simulator.new(20, 120)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 2957.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 3168.0}]
				)
			end
			it '300kwまでの電気使用量' do
				simulator = Simulator.new(20, 300)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 8516.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 7920.0}]
				)
			end
			it '300kw以上の電気使用量' do
				simulator = Simulator.new(20, 400)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 12800.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 10560.0}]
				)
			end
		end

		context "契約アンペア数が30A" do
			it '120kwまでの電気使用量' do
				simulator = Simulator.new(30, 120)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 3243.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 3168.0}],
					[{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 3698.0}],
					[{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 3243.0}]
				)
			end
			it '140kwまでの電気使用量' do
				simulator = Simulator.new(30, 140)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 4565.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 3696.0}],
					[{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 4171.0}],
					[{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 4565.0}]
				)
			end
			it '300kwまでの電気使用量' do
				simulator = Simulator.new(30, 300)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 8802.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 7920.0}],
					[{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 8022.0}],
					[{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 8802.0}]
				)
			end
			it '350kwまでの電気使用量' do
				simulator = Simulator.new(30, 350)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 11557.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 9240.0}],
					[{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 9216.0}],
					[{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 9636.0}]
				)
			end
			it '600kwまでの電気使用量' do
				simulator = Simulator.new(30, 600)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 19200.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 15840.0}],
					[{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 16704.0}],
					[{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 15905.0}]
				)
			end
			it '600kw以上の電気使用量' do
				simulator = Simulator.new(30, 700)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 22257.0}],
					[{:supplier => "Looop", :plan => "おうちプラン", :price => 18480.0}],
					[{:supplier => "東京ガス", :plan => "ずっとも電気1", :price => 19345.0}],
					[{:supplier => "JXTG", :plan => "従量電灯B たっぷりプラン", :price => 19163.0}]
				)
			end
		end
	end
end
