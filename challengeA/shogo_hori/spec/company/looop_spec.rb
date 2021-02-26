RSpec.describe Charges do
  describe 'Looopでんきおうちでんきプラン' do
    context '10A' do
      it '0kWh' do
        charges = Charges.new(10, 0)
        expect(charges.looop).to eq 0
      end

      it '1kWh' do
        charges = Charges.new(10, 1)
        expect(charges.looop).to eq 26
      end

      it '50kWh' do
        charges = Charges.new(10, 50)
        expect(charges.looop).to eq 1320
      end

      it '100kWh' do
        charges = Charges.new(10, 100)
        expect(charges.looop).to eq 2640
      end

      it '200kWh' do
        charges = Charges.new(10, 200)
        expect(charges.looop).to eq 5280
      end

      it '300kWh' do
        charges = Charges.new(10, 300)
        expect(charges.looop).to eq 7920
      end

      it '400kWh' do
        charges = Charges.new(10, 400)
        expect(charges.looop).to eq 10_560
      end

      it '999999kWh' do
        charges = Charges.new(10, 999_999)
        expect(charges.looop).to eq 26_399_973
      end

      it '110.46kWh *使用量の四捨五入処理が正しいか' do
        charges = Charges.new(10, 110.46)
        expect(charges.looop).to eq 2904
      end

      it '198.65kWh *使用量の四捨五入処理が正しいか' do
        charges = Charges.new(10, 198.65)
        expect(charges.looop).to eq 5253
      end
    end

    context '15A' do
      it '0kWh' do
        charges = Charges.new(15, 0)
        expect(charges.looop).to eq 0
      end

      it '50kWh' do
        charges = Charges.new(15, 50)
        expect(charges.looop).to eq 1320
      end
    end

    context '20A' do
      it '0kWh' do
        charges = Charges.new(20, 0)
        expect(charges.looop).to eq 0
      end

      it '50kWh' do
        charges = Charges.new(20, 50)
        expect(charges.looop).to eq 1320
      end
    end

    context '30A' do
      it '0kWh' do
        charges = Charges.new(30, 0)
        expect(charges.looop).to eq 0
      end

      it '50kWh' do
        charges = Charges.new(30, 50)
        expect(charges.looop).to eq 1320
      end
    end

    context '40A' do
      it '0kWh' do
        charges = Charges.new(40, 0)
        expect(charges.looop).to eq 0
      end

      it '50kWh' do
        charges = Charges.new(40, 50)
        expect(charges.looop).to eq 1320
      end
    end

    context '50A' do
      it '0kWh' do
        charges = Charges.new(50, 0)
        expect(charges.looop).to eq 0
      end

      it '50kWh' do
        charges = Charges.new(50, 50)
        expect(charges.looop).to eq 1320
      end
    end

    context '60A' do
      it '0kWh' do
        charges = Charges.new(60, 0)
        expect(charges.looop).to eq 0
      end

      it '50kWh' do
        charges = Charges.new(60, 50)
        expect(charges.looop).to eq 1320
      end
    end
  end
end
