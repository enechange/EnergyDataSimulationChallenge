RSpec.describe Charges do
  describe 'Looopでんきおうちでんきプラン' do
    context '10A' do
      it '0kWh' do
        simulator = Simulator.new(10, 0)
        expect(simulator.calculate('csv/looop')).to eq 0
      end

      it '1kWh' do
        simulator = Simulator.new(10, 1)
        expect(simulator.calculate('csv/looop')).to eq 26
      end

      it '50kWh' do
        simulator = Simulator.new(10, 50)
        expect(simulator.calculate('csv/looop')).to eq 1320
      end

      it '100kWh' do
        simulator = Simulator.new(10, 100)
        expect(simulator.calculate('csv/looop')).to eq 2640
      end

      it '200kWh' do
        simulator = Simulator.new(10, 200)
        expect(simulator.calculate('csv/looop')).to eq 5280
      end

      it '300kWh' do
        simulator = Simulator.new(10, 300)
        expect(simulator.calculate('csv/looop')).to eq 7920
      end

      it '400kWh' do
        simulator = Simulator.new(10, 400)
        expect(simulator.calculate('csv/looop')).to eq 10_560
      end

      it '999999kWh' do
        simulator = Simulator.new(10, 999_999)
        expect(simulator.calculate('csv/looop')).to eq 26_399_973
      end

      it '110.46kWh *使用量の四捨五入処理が正しいか' do
        simulator = Simulator.new(10, 110.46)
        expect(simulator.calculate('csv/looop')).to eq 2904
      end

      it '198.65kWh *使用量の四捨五入処理が正しいか' do
        simulator = Simulator.new(10, 198.65)
        expect(simulator.calculate('csv/looop')).to eq 5253
      end
    end

    context '15A' do
      it '0kWh' do
        simulator = Simulator.new(15, 0)
        expect(simulator.calculate('csv/looop')).to eq 0
      end

      it '50kWh' do
        simulator = Simulator.new(15, 50)
        expect(simulator.calculate('csv/looop')).to eq 1320
      end
    end

    context '20A' do
      it '0kWh' do
        simulator = Simulator.new(20, 0)
        expect(simulator.calculate('csv/looop')).to eq 0
      end

      it '50kWh' do
        simulator = Simulator.new(20, 50)
        expect(simulator.calculate('csv/looop')).to eq 1320
      end
    end

    context '30A' do
      it '0kWh' do
        simulator = Simulator.new(30, 0)
        expect(simulator.calculate('csv/looop')).to eq 0
      end

      it '50kWh' do
        simulator = Simulator.new(30, 50)
        expect(simulator.calculate('csv/looop')).to eq 1320
      end
    end

    context '40A' do
      it '0kWh' do
        simulator = Simulator.new(40, 0)
        expect(simulator.calculate('csv/looop')).to eq 0
      end

      it '50kWh' do
        simulator = Simulator.new(40, 50)
        expect(simulator.calculate('csv/looop')).to eq 1320
      end
    end

    context '50A' do
      it '0kWh' do
        simulator = Simulator.new(50, 0)
        expect(simulator.calculate('csv/looop')).to eq 0
      end

      it '50kWh' do
        simulator = Simulator.new(50, 50)
        expect(simulator.calculate('csv/looop')).to eq 1320
      end
    end

    context '60A' do
      it '0kWh' do
        simulator = Simulator.new(60, 0)
        expect(simulator.calculate('csv/looop')).to eq 0
      end

      it '50kWh' do
        simulator = Simulator.new(60, 50)
        expect(simulator.calculate('csv/looop')).to eq 1320
      end
    end
  end
end
