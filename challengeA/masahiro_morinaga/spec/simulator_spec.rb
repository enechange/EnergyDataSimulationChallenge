require '../lib/simulator.rb'

RSpec.describe Simulator do
	describe '電気料金とプラン' do
		context "契約アンペア数が10A" do
			it '120kwまでの電気使用量' do
				simulator = Simulator.new(10, 120)
				expect(simulator.simulate).to  contain_exactly(
					[{:supplier => "東京電力", :plan => "従量電灯B", :price => 2671.0}],
					[{:supplier=>"Looop", :plan=>"おうちプラン", :price=>3168.0}]
				)
			end
		end
		
	end
end
