# frozen_string_literal: true

RSpec.describe Calculate do
  describe '東京電力エナジーパートナー従量電灯Bの料金計算' do
    context '10A' do
      it '120kWh' do
        calculate = Calculate.new(10, 120)
        expect(calculate.tokyo_denryoku_plan).to eq '2671'
      end

      it '121kWh' do
        calculate = Calculate.new(10, 121)
        expect(calculate.tokyo_denryoku_plan).to eq '2698'
      end

      it '300kWh' do
        calculate = Calculate.new(10, 300)
        expect(calculate.tokyo_denryoku_plan).to eq '7438'
      end

      it '301kWh' do
        calculate = Calculate.new(10, 301)
        expect(calculate.tokyo_denryoku_plan).to eq '7468'
      end
    end

    context '15A' do
      it '120kWh' do
        calculate = Calculate.new(15, 120)
        expect(calculate.tokyo_denryoku_plan).to eq '2814'
      end

      it '121kWh' do
        calculate = Calculate.new(15, 121)
        expect(calculate.tokyo_denryoku_plan).to eq '2841'
      end

      it '300kWh' do
        calculate = Calculate.new(15, 300)
        expect(calculate.tokyo_denryoku_plan).to eq '7581'
      end

      it '301kWh' do
        calculate = Calculate.new(15, 301)
        expect(calculate.tokyo_denryoku_plan).to eq '7611'
      end
    end

    context '20A' do
      it '120kWh' do
        calculate = Calculate.new(20, 120)
        expect(calculate.tokyo_denryoku_plan).to eq '2957'
      end

      it '121kWh' do
        calculate = Calculate.new(20, 121)
        expect(calculate .tokyo_denryoku_plan).to eq '2984'
      end

      it '300kWh' do
        calculate = Calculate.new(20, 300)
        expect(calculate.tokyo_denryoku_plan).to eq '7724'
      end

      it '301kWh' do
        calculate = Calculate.new(10, 301)
        expect(calculate.tokyo_denryoku_plan).to eq '7468'
      end
    end

    context '30A' do
      it '120kWh' do
        calculate = Calculate.new(30, 120)
        expect(calculate.tokyo_denryoku_plan).to eq '3243'
      end

      it '121kWh' do
        calculate = Calculate.new(30, 121)
        expect(calculate.tokyo_denryoku_plan).to eq '3270'
      end

      it '300kWh' do
        calculate = Calculate.new(30, 300)
        expect(calculate.tokyo_denryoku_plan).to eq '8010'
      end

      it '301kWh' do
        calculate = Calculate.new(30, 301)
        expect(calculate.tokyo_denryoku_plan).to eq '8040'
      end
    end

    context '40A' do
      it '120kWh' do
        calculate = Calculate.new(40, 120)
        expect(calculate.tokyo_denryoku_plan).to eq '3529'
      end

      it '121kWh' do
        calculate = Calculate.new(40, 121)
        expect(calculate.tokyo_denryoku_plan).to eq '3556'
      end

      it '300kWh' do
        calculate = Calculate.new(40, 300)
        expect(calculate.tokyo_denryoku_plan).to eq '8296'
      end

      it '301kWh' do
        calculate = Calculate.new(40, 301)
        expect(calculate.tokyo_denryoku_plan).to eq '8326'
      end
    end

    context '50A' do
      it '120kWh' do
        calculate = Calculate.new(50, 120)
        expect(calculate.tokyo_denryoku_plan).to eq '3815'
      end

      it '121kWh' do
        calculate = Calculate.new(50, 121)
        expect(calculate.tokyo_denryoku_plan).to eq '3842'
      end

      it '300kWh' do
        calculate = Calculate.new(50, 300)
        expect(calculate.tokyo_denryoku_plan).to eq '8582'
      end

      it '301kWh' do
        calculate = Calculate.new(50, 301)
        expect(calculate.tokyo_denryoku_plan).to eq '8612'
      end
    end

    context '60A' do
      it '120kWh' do
        calculate = Calculate.new(60, 120)
        expect(calculate.tokyo_denryoku_plan).to eq '4101'
      end

      it '121kWh' do
        calculate = Calculate.new(60, 121)
        expect(calculate.tokyo_denryoku_plan).to eq '4128'
      end

      it '300kWh' do
        calculate = Calculate.new(60, 300)
        expect(calculate.tokyo_denryoku_plan).to eq '8868'
      end

      it '301kWh' do
        calculate = Calculate.new(60, 301)
        expect(calculate.tokyo_denryoku_plan).to eq '8898'
      end
    end
  end
end
