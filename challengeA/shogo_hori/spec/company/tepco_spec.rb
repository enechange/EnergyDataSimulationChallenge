require_relative '../../charges'

RSpec.describe Charges do
  describe '東京電力エナジーパートナー従量電灯B' do
    context '10A' do
      it '0kWh' do
        charges = Charges.new(10, 0)
        expect(charges.tepco).to eq 286
      end

      it '5kWh' do
        charges = Charges.new(10, 5)
        expect(charges.tepco).to eq 385
      end
    end
  end
end
