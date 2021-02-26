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
        charges = Charges.new(10, 999_999)
        expect(charges.tepco).to eq 30_570_255
      end

      it '110.46kWh *使用量の四捨五入処理が正しいか' do
        charges = Charges.new(10, 110.46)
        expect(charges.tepco).to eq 2472
      end

      it '198.65kWh *使用量の四捨五入処理が正しいか' do
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
        charges = Charges.new(15, 999_999)
        expect(charges.tepco).to eq 30_570_398
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
        charges = Charges.new(20, 999_999)
        expect(charges.tepco).to eq 30_570_541
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
        expect(charges.tepco).to eq 10_059
      end

      it '999999kWh' do
        charges = Charges.new(30, 999_999)
        expect(charges.tepco).to eq 30_570_827
      end
    end

    context '40A' do
      it '0kWh' do
        charges = Charges.new(40, 0)
        expect(charges.tepco).to eq 1144
      end

      it '1kWh' do
        charges = Charges.new(40, 1)
        expect(charges.tepco).to eq 1163
      end

      it '60kWh' do
        charges = Charges.new(40, 60)
        expect(charges.tepco).to eq 2336
      end

      it '120kWh' do
        charges = Charges.new(40, 120)
        expect(charges.tepco).to eq 3529
      end

      it '121kWh' do
        charges = Charges.new(40, 121)
        expect(charges.tepco).to eq 4348
      end

      it '210kWh' do
        charges = Charges.new(40, 210)
        expect(charges.tepco).to eq 6704
      end

      it '300kWh' do
        charges = Charges.new(40, 300)
        expect(charges.tepco).to eq 9088
      end

      it '301kWh' do
        charges = Charges.new(40, 301)
        expect(charges.tepco).to eq 10_345
      end

      it '999999kWh' do
        charges = Charges.new(40, 999_999)
        expect(charges.tepco).to eq 30_571_113
      end
    end

    context '50A' do
      it '0kWh' do
        charges = Charges.new(50, 0)
        expect(charges.tepco).to eq 1430
      end

      it '1kWh' do
        charges = Charges.new(50, 1)
        expect(charges.tepco).to eq 1449
      end

      it '60kWh' do
        charges = Charges.new(50, 60)
        expect(charges.tepco).to eq 2622
      end

      it '120kWh' do
        charges = Charges.new(50, 120)
        expect(charges.tepco).to eq 3815
      end

      it '121kWh' do
        charges = Charges.new(50, 121)
        expect(charges.tepco).to eq 4634
      end

      it '210kWh' do
        charges = Charges.new(50, 210)
        expect(charges.tepco).to eq 6990
      end

      it '300kWh' do
        charges = Charges.new(50, 300)
        expect(charges.tepco).to eq 9374
      end

      it '301kWh' do
        charges = Charges.new(50, 301)
        expect(charges.tepco).to eq 10_631
      end

      it '999999kWh' do
        charges = Charges.new(50, 999_999)
        expect(charges.tepco).to eq 30_571_399
      end
    end

    context '60A' do
      it '0kWh' do
        charges = Charges.new(60, 0)
        expect(charges.tepco).to eq 1716
      end

      it '1kWh' do
        charges = Charges.new(60, 1)
        expect(charges.tepco).to eq 1735
      end

      it '60kWh' do
        charges = Charges.new(60, 60)
        expect(charges.tepco).to eq 2908
      end

      it '120kWh' do
        charges = Charges.new(60, 120)
        expect(charges.tepco).to eq 4101
      end

      it '121kWh' do
        charges = Charges.new(60, 121)
        expect(charges.tepco).to eq 4920
      end

      it '210kWh' do
        charges = Charges.new(60, 210)
        expect(charges.tepco).to eq 7276
      end

      it '300kWh' do
        charges = Charges.new(60, 300)
        expect(charges.tepco).to eq 9660
      end

      it '301kWh' do
        charges = Charges.new(60, 301)
        expect(charges.tepco).to eq 10_917
      end

      it '999999kWh' do
        charges = Charges.new(60, 999_999)
        expect(charges.tepco).to eq 30_571_685
      end
    end
  end
end
