require_relative '../../lib/charges'

RSpec.describe Charges do
  describe '東京電力エナジーパートナー従量電灯B' do
    context '10A' do
      it '0kWh' do
        charges = Charges.new(10, 0)
        expect(charges.tepco).to eq 286
      end

      it '1kWh' do
        charges = Charges.new(10, 1)
        expect(charges.tepco).to eq 305
      end

      it '60kWh' do
        charges = Charges.new(10, 60)
        expect(charges.tepco).to eq 1478
      end

      it '120kWh' do
        charges = Charges.new(10, 120)
        expect(charges.tepco).to eq 2671
      end

      it '121kWh' do
        charges = Charges.new(10, 121)
        expect(charges.tepco).to eq 3490
      end

      it '210kWh' do
        charges = Charges.new(10, 210)
        expect(charges.tepco).to eq 5846
      end

      it '300kWh' do
        charges = Charges.new(10, 300)
        expect(charges.tepco).to eq 8230
      end

      it '301kWh' do
        charges = Charges.new(10, 301)
        expect(charges.tepco).to eq 9487
      end

      it '999999kWh' do
        charges = Charges.new(10, 999999)
        expect(charges.tepco).to eq 30570255
      end

      it '198.65kWh *四捨五入処理が正しいか' do
        charges = Charges.new(10, 198.65)
        expect(charges.tepco).to eq 5555
      end

      it '198.65kWh *四捨五入処理が正しいか' do
        charges = Charges.new(10, 198.65)
        expect(charges.tepco).to eq 5555
      end
    end

    context '15A' do
      it '0kWh' do
        charges = Charges.new(15, 0)
        expect(charges.tepco).to eq 429
      end

      it '1kWh' do
        charges = Charges.new(15, 1)
        expect(charges.tepco).to eq 448
      end

      it '60kWh' do
        charges = Charges.new(15, 60)
        expect(charges.tepco).to eq 1621
      end

      it '120kWh' do
        charges = Charges.new(15, 120)
        expect(charges.tepco).to eq 2814
      end

      it '121kWh' do
        charges = Charges.new(15, 121)
        expect(charges.tepco).to eq 3633
      end

      it '210kWh' do
        charges = Charges.new(15, 210)
        expect(charges.tepco).to eq 5989
      end

      it '300kWh' do
        charges = Charges.new(15, 300)
        expect(charges.tepco).to eq 8373
      end

      it '301kWh' do
        charges = Charges.new(15, 301)
        expect(charges.tepco).to eq 9630
      end

      it '999999kWh' do
        charges = Charges.new(15, 999999)
        expect(charges.tepco).to eq 30570398
      end

      it '198.65kWh *四捨五入処理が正しいか' do
        charges = Charges.new(15, 198.65)
        expect(charges.tepco).to eq 5698
      end
    end

    context '20A' do
      it '0kWh' do
        charges = Charges.new(20, 0)
        expect(charges.tepco).to eq 572
      end

      it '1kWh' do
        charges = Charges.new(20, 1)
        expect(charges.tepco).to eq 591
      end

      it '60kWh' do
        charges = Charges.new(20, 60)
        expect(charges.tepco).to eq 1764
      end

      it '120kWh' do
        charges = Charges.new(20, 120)
        expect(charges.tepco).to eq 2957
      end

      it '121kWh' do
        charges = Charges.new(20, 121)
        expect(charges.tepco).to eq 3776
      end

      it '210kWh' do
        charges = Charges.new(20, 210)
        expect(charges.tepco).to eq 6132
      end

      it '300kWh' do
        charges = Charges.new(20, 300)
        expect(charges.tepco).to eq 8516
      end

      it '301kWh' do
        charges = Charges.new(20, 301)
        expect(charges.tepco).to eq 9773
      end

      it '999999kWh' do
        charges = Charges.new(20, 999999)
        expect(charges.tepco).to eq 30570541
      end

      it '198.65kWh *四捨五入処理が正しいか' do
        charges = Charges.new(20, 198.65)
        expect(charges.tepco).to eq 5841
      end
    end

    context '30A' do
      it '0kWh' do
        charges = Charges.new(30, 0)
        expect(charges.tepco).to eq 858
      end

      it '1kWh' do
        charges = Charges.new(30, 1)
        expect(charges.tepco).to eq 877
      end

      it '60kWh' do
        charges = Charges.new(30, 60)
        expect(charges.tepco).to eq 2050
      end

      it '120kWh' do
        charges = Charges.new(30, 120)
        expect(charges.tepco).to eq 3243
      end

      it '121kWh' do
        charges = Charges.new(30, 121)
        expect(charges.tepco).to eq 4062
      end

      it '210kWh' do
        charges = Charges.new(30, 210)
        expect(charges.tepco).to eq 6418
      end

      it '300kWh' do
        charges = Charges.new(30, 300)
        expect(charges.tepco).to eq 8802
      end

      it '301kWh' do
        charges = Charges.new(30, 301)
        expect(charges.tepco).to eq 10059
      end

      it '999999kWh' do
        charges = Charges.new(30, 999999)
        expect(charges.tepco).to eq 30570827
      end

      it '198.65kWh *四捨五入処理が正しいか' do
        charges = Charges.new(30, 198.65)
        expect(charges.tepco).to eq 6127
      end
    end

  end
end
