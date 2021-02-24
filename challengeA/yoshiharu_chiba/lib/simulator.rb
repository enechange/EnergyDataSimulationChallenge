# frozen_string_literal: true

require 'rspec/autorun'
require 'json'

class Simulator
  def initialize(amps, amount_per_month)
    @amps = amps
    @amount_per_month = amount_per_month
  end

  def simulate
    json_file_path = File.expand_path('json_plan.json', __dir__)
    data = File.open(json_file_path) do |file|
      JSON.load(file).each do |plan|
        case
        when plan['provider_name'] == "東京電力エナジーパートナー" then plan['price'] = (plan['basic_price']["#{@amps}"] + tokyo_denryoku_amount_price).floor.to_s
        when plan['provider_name'] == "Looopでんき" then plan['price'] = (@amount_per_month * 26.40).floor.to_s
        when plan['provider_name'] == "東京ガス" && ["30", "40", "50", "60"].include?("#{@amps}") then plan["price"] = (plan['basic_price']["#{@amps}"] + tokyo_gas_amount_price).floor.to_s
        end
      end
    end
    select_data = data.map { |h| h.select { |k, _v| ["provider_name", "plan_name", "price"].include?(k) }}
    plans = select_data.map do |plan|
      plan unless plan['price'].empty?
    end.compact
    p plans
  end

  private

  def tokyo_denryoku_amount_price
    case @amount_per_month
    when 0..120 then @amount_per_month * 19.88
    when 121..300 then 120 * 19.88 + (@amount_per_month - 120) * 26.48
    else 120 * 19.88 + 180 * 26.48 + (@amount_per_month - 300) * 30.57
    end
  end

  def tokyo_gas_amount_price
    case @amount_per_month
    when 0..140 then @amount_per_month * 23.67
    when 141..350 then 140 * 23.67 + (@amount_per_month - 140) * 23.88
    else 140 * 23.67 + 210 * 23.88 + (@amount_per_month - 350) * 26.41
    end
  end
end

amps_range = [10, 15, 20, 30, 40, 50, 60]
puts '10, 15, 20, 30, 40, 50, 60の中から契約しているアンペア数(A)を入力してください。'
amps = gets.to_i
unless amps_range.include?(amps)
  puts "入力されたアンペア数が正しくありません。\n10, 15, 20, 30, 40, 50, 60の中から選択してください。"
  amps = gets.to_i
end

puts '1ヶ月あたりの使用量(kWh)を入力してください。'
amount_per_month = gets.to_f.round
unless amount_per_month >= 0
  puts "入力された使用量が正しくありません。\n再度入力してください。"
  amount_per_month = gets.to_f.round
end

simulator = Simulator.new(amps, amount_per_month)
simulator.simulate


# 以下テストコード
RSpec.describe Simulator do
  describe 'プラン名とそのプラン料金を配列で返す' do
    context '10A場合' do
      it '10A/120kWhの場合は2つの電力会社のプランを返す' do
        simulator = Simulator.new(10, 120)
        expect(simulator.simulate).to contain_exactly(
          { 'plan_name' => '従量電灯Bプラン', 'price' => '2671', 'provider_name' => '東京電力エナジーパートナー' },
          { 'plan_name' => 'おうちプラン', 'price' => '3168', 'provider_name' => 'Looopでんき' }
        )
      end

      it '10A/121kWhの場合は2つの電力会社のプランを返す' do
        simulator = Simulator.new(10, 121)
        expect(simulator.simulate).to contain_exactly(
          { 'plan_name' => '従量電灯Bプラン', 'price' => '2698', 'provider_name' => '東京電力エナジーパートナー' },
          { 'plan_name' => 'おうちプラン', 'price' => '3194', 'provider_name' => 'Looopでんき' }
        )
      end

      it '10A/300kWhの場合は2つの電力会社のプランを返す' do
        simulator = Simulator.new(10, 300)
        expect(simulator.simulate).to contain_exactly(
          { 'plan_name' => '従量電灯Bプラン', 'price' => '7438', 'provider_name' => '東京電力エナジーパートナー' },
          { 'plan_name' => 'おうちプラン', 'price' => '7920', 'provider_name' => 'Looopでんき' }
        )
      end

      it '10A/301kWhの場合は2つの電力会社のプランを返す' do
        simulator = Simulator.new(10, 301)
        expect(simulator.simulate).to contain_exactly(
          { 'plan_name' => '従量電灯Bプラン', 'price' => '7468', 'provider_name' => '東京電力エナジーパートナー' },
          { 'plan_name' => 'おうちプラン', 'price' => '7946', 'provider_name' => 'Looopでんき' }
        )
      end
    end

    context '20Aの場合' do
      it '20A/120kWhの場合は2つの電力会社のプランを返す' do
        simulator = Simulator.new(20, 120)
        expect(simulator.simulate).to contain_exactly(
          { 'plan_name' => '従量電灯Bプラン', 'price' => '2957', 'provider_name' => '東京電力エナジーパートナー' },
          { 'plan_name' => 'おうちプラン', 'price' => '3168', 'provider_name' => 'Looopでんき' }
        )
      end

      it '20A/121kWhの場合は2つの電力会社のプランを返す' do
        simulator = Simulator.new(20, 121)
        expect(simulator.simulate).to contain_exactly(
          { 'plan_name' => '従量電灯Bプラン', 'price' => '2984', 'provider_name' => '東京電力エナジーパートナー' },
          { 'plan_name' => 'おうちプラン', 'price' => '3194', 'provider_name' => 'Looopでんき' }
        )
      end

      it '20A/300kWhの場合は2つの電力会社のプランを返す' do
        simulator = Simulator.new(20, 300)
        expect(simulator.simulate).to contain_exactly(
          { 'plan_name' => '従量電灯Bプラン', 'price' => '7724', 'provider_name' => '東京電力エナジーパートナー' },
          { 'plan_name' => 'おうちプラン', 'price' => '7920', 'provider_name' => 'Looopでんき' }
        )
      end

      it '20A/301kWhの場合は2つの電力会社のプランを返す' do
        simulator = Simulator.new(20, 301)
        expect(simulator.simulate).to contain_exactly(
          { 'plan_name' => '従量電灯Bプラン', 'price' => '7754', 'provider_name' => '東京電力エナジーパートナー' },
          { 'plan_name' => 'おうちプラン', 'price' => '7946', 'provider_name' => 'Looopでんき' }
        )
      end
    end

    context '30Aの場合' do
      it '30A/140kWhの場合は3つの電力会社のプランを返す' do
        simulator = Simulator.new(30, 140)
        expect(simulator.simulate).to contain_exactly(
          { 'provider_name' => '東京電力エナジーパートナー', 'plan_name' => '従量電灯Bプラン', 'price' => '3773' },
          { 'provider_name' => 'Looopでんき', 'plan_name' => 'おうちプラン', 'price' => '3696' },
          { 'provider_name' => '東京ガス', 'plan_name' => 'ずっとも電気１プラン', 'price' => '4171' }
        )
      end

      it '30A/141kWhの場合は3つの電力会社のプランを返す' do
        simulator = Simulator.new(30, 141)
        expect(simulator.simulate).to contain_exactly(
          { 'provider_name' => '東京電力エナジーパートナー', 'plan_name' => '従量電灯Bプラン', 'price' => '3799' },
          { 'provider_name' => 'Looopでんき', 'plan_name' => 'おうちプラン', 'price' => '3722' },
          { 'provider_name' => '東京ガス', 'plan_name' => 'ずっとも電気１プラン', 'price' => '4195' }
        )
      end

      it '30A/350kWhの場合は3つの電力会社のプランを返す' do
        simulator = Simulator.new(30, 350)
        expect(simulator.simulate).to contain_exactly(
          { 'provider_name' => '東京電力エナジーパートナー', 'plan_name' => '従量電灯Bプラン', 'price' => '9538' },
          { 'provider_name' => 'Looopでんき', 'plan_name' => 'おうちプラン', 'price' => '9240' },
          { 'provider_name' => '東京ガス', 'plan_name' => 'ずっとも電気１プラン', 'price' => '9186' }
        )
      end

      it '30A/351kWhの場合は3つの電力会社のプランを返す' do
        simulator = Simulator.new(30, 351)
        expect(simulator.simulate).to contain_exactly(
          { 'provider_name' => '東京電力エナジーパートナー', 'plan_name' => '従量電灯Bプラン', 'price' => '9569' },
          { 'provider_name' => 'Looopでんき', 'plan_name' => 'おうちプラン', 'price' => '9266' },
          { 'provider_name' => '東京ガス', 'plan_name' => 'ずっとも電気１プラン', 'price' => '9213' }
        )
      end
    end

    context '60Aの場合' do
      it '60A/140kWhの場合は3つの電力会社のプランを返す' do
        simulator = Simulator.new(60, 140)
        expect(simulator.simulate).to contain_exactly(
          { 'provider_name' => '東京電力エナジーパートナー', 'plan_name' => '従量電灯Bプラン', 'price' => '4631' },
          { 'provider_name' => 'Looopでんき', 'plan_name' => 'おうちプラン', 'price' => '3696' },
          { 'provider_name' => '東京ガス', 'plan_name' => 'ずっとも電気１プラン', 'price' => '5029' }
        )
      end

      it '60A/141kWhの場合は3つの電力会社のプランを返す' do
        simulator = Simulator.new(60, 141)
        expect(simulator.simulate).to contain_exactly(
          { 'provider_name' => '東京電力エナジーパートナー', 'plan_name' => '従量電灯Bプラン', 'price' => '4657' },
          { 'provider_name' => 'Looopでんき', 'plan_name' => 'おうちプラン', 'price' => '3722' },
          { 'provider_name' => '東京ガス', 'plan_name' => 'ずっとも電気１プラン', 'price' => '5053' }
        )
      end

      it '60A/350kWhの場合は3つの電力会社のプランを返す' do
        simulator = Simulator.new(60, 350)
        expect(simulator.simulate).to contain_exactly(
          { 'provider_name' => '東京電力エナジーパートナー', 'plan_name' => '従量電灯Bプラン', 'price' => '10396' },
          { 'provider_name' => 'Looopでんき', 'plan_name' => 'おうちプラン', 'price' => '9240' },
          { 'provider_name' => '東京ガス', 'plan_name' => 'ずっとも電気１プラン', 'price' => '10044' }
        )
      end

      it '60A/351kWhの場合は3つの電力会社のプランを返す' do
        simulator = Simulator.new(60, 351)
        expect(simulator.simulate).to contain_exactly(
          { 'provider_name' => '東京電力エナジーパートナー', 'plan_name' => '従量電灯Bプラン', 'price' => '10427' },
          { 'provider_name' => 'Looopでんき', 'plan_name' => 'おうちプラン', 'price' => '9266' },
          { 'provider_name' => '東京ガス', 'plan_name' => 'ずっとも電気１プラン', 'price' => '10071' }
        )
      end
    end
  end
end
