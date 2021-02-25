RSpec.describe Charges do
  describe '東京ガスずっとも電気１' do
    context '30A' do
      it '0kWh' do
        charges = Charges.new(30, 0)
        expect(charges.tokyo_gas).to eq 858
      end

      it '1kWh' do
        charges = Charges.new(30, 1)
        expect(charges.tokyo_gas).to eq 881
      end

      it '70kWh' do
        charges = Charges.new(30, 70)
        expect(charges.tokyo_gas).to eq 2514
      end

      it '140kWh' do
        charges = Charges.new(30, 140)
        expect(charges.tokyo_gas).to eq 4171
      end

      it '141kWh' do
        charges = Charges.new(30, 141)
        expect(charges.tokyo_gas).to eq 4225
      end

      it '245kWh' do
        charges = Charges.new(30, 245)
        expect(charges.tokyo_gas).to eq 6708
      end

      it '350kWh' do
        charges = Charges.new(30, 350)
        expect(charges.tokyo_gas).to eq 9216
      end

      it '351kWh' do
        charges = Charges.new(30, 351)
        expect(charges.tokyo_gas).to eq 10127
      end

      it '999999kWh' do
        charges = Charges.new(30, 999999)
        expect(charges.tokyo_gas).to eq 26410831
      end

      it '110.46kWh *使用量の四捨五入処理が正しいか' do
        charges = Charges.new(30, 110.46)
        expect(charges.tokyo_gas).to eq 3461
      end

      it '198.65kWh *使用量の四捨五入処理が正しいか' do
        charges = Charges.new(30, 198.65)
        expect(charges.tokyo_gas).to eq 5610
      end
    end

    context '40A' do
      it '0kWh' do
        charges = Charges.new(40, 0)
        expect(charges.tokyo_gas).to eq 1144
      end

      it '1kWh' do
        charges = Charges.new(40, 1)
        expect(charges.tokyo_gas).to eq 1167
      end

      it '70kWh' do
        charges = Charges.new(40, 70)
        expect(charges.tokyo_gas).to eq 2800
      end

      it '140kWh' do
        charges = Charges.new(40, 140)
        expect(charges.tokyo_gas).to eq 4457
      end

      it '141kWh' do
        charges = Charges.new(40, 141)
        expect(charges.tokyo_gas).to eq 4511
      end

      it '245kWh' do
        charges = Charges.new(40, 245)
        expect(charges.tokyo_gas).to eq 6994
      end

      it '350kWh' do
        charges = Charges.new(40, 350)
        expect(charges.tokyo_gas).to eq 9502
      end

      it '351kWh' do
        charges = Charges.new(40, 351)
        expect(charges.tokyo_gas).to eq 10413
      end

      it '999999kWh' do
        charges = Charges.new(40, 999999)
        expect(charges.tokyo_gas).to eq 26411117
      end
    end

    context '50A' do
      it '0kWh' do
        charges = Charges.new(50, 0)
        expect(charges.tokyo_gas).to eq 1430
      end

      it '1kWh' do
        charges = Charges.new(50, 1)
        expect(charges.tokyo_gas).to eq 1453
      end

      it '70kWh' do
        charges = Charges.new(50, 70)
        expect(charges.tokyo_gas).to eq 3086
      end

      it '140kWh' do
        charges = Charges.new(50, 140)
        expect(charges.tokyo_gas).to eq 4743
      end

      it '141kWh' do
        charges = Charges.new(50, 141)
        expect(charges.tokyo_gas).to eq 4797
      end

      it '245kWh' do
        charges = Charges.new(50, 245)
        expect(charges.tokyo_gas).to eq 7280
      end

      it '350kWh' do
        charges = Charges.new(50, 350)
        expect(charges.tokyo_gas).to eq 9788
      end

      it '351kWh' do
        charges = Charges.new(50, 351)
        expect(charges.tokyo_gas).to eq 10699
      end

      it '999999kWh' do
        charges = Charges.new(50, 999999)
        expect(charges.tokyo_gas).to eq 26411403
      end
    end

    context '60A' do
      it '0kWh' do
        charges = Charges.new(60, 0)
        expect(charges.tokyo_gas).to eq 1716
      end

      it '1kWh' do
        charges = Charges.new(60, 1)
        expect(charges.tokyo_gas).to eq 1739
      end

      it '70kWh' do
        charges = Charges.new(60, 70)
        expect(charges.tokyo_gas).to eq 3372
      end

      it '140kWh' do
        charges = Charges.new(60, 140)
        expect(charges.tokyo_gas).to eq 5029
      end

      it '141kWh' do
        charges = Charges.new(60, 141)
        expect(charges.tokyo_gas).to eq 5083
      end

      it '245kWh' do
        charges = Charges.new(60, 245)
        expect(charges.tokyo_gas).to eq 7566
      end

      it '350kWh' do
        charges = Charges.new(60, 350)
        expect(charges.tokyo_gas).to eq 10074
      end

      it '351kWh' do
        charges = Charges.new(60, 351)
        expect(charges.tokyo_gas).to eq 10985
      end

      it '999999kWh' do
        charges = Charges.new(60, 999999)
        expect(charges.tokyo_gas).to eq 26411689
      end
    end
  end
end
