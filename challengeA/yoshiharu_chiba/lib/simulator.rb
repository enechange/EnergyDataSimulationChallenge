# frozen_string_literal: true

require_relative '../lib/companies/tokyo_denryoku'
require_relative '../lib/companies/looop'
require_relative '../lib/companies/tokyo_gas'

class Simulator
  def initialize(amps, amount_per_month)
    @amps = amps
    @amount_per_month = amount_per_month
  end

  def simulate
    # 東京電力の計算
    tokyo_denryoku_price = tokyo_denryoku_plan(@amps, @amount_per_month)

    # ループ電気の計算
    looop_price = looop_plan(@amps, @amount_per_month)

    # 東京ガスの計算
    tokyo_gas_price = tokyo_gas_plan(@amps, @amount_per_month) if [30, 40, 50, 60].include?(@amps)

    # 新規電力会社の計算
    # hoge_price = hoge_plan(@amps, @amount_per_month)

    if tokyo_gas_price.nil?
      p [
        { provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯Bプラン', price: tokyo_denryoku_price.to_s },
        { provider_name: 'Looopでんき', plan_name: 'おうちプラン', price: looop_price.to_s }
      ]
    else
      p [
        { provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯Bプラン', price: tokyo_denryoku_price.to_s },
        { provider_name: 'Looopでんき', plan_name: 'おうちプラン', price: looop_price.to_s },
        { provider_name: '東京ガス', plan_name: 'ずっとも電気１プラン', price: tokyo_gas_price.to_s }
      ]
    end
  end

  private

  def tokyo_denryoku_plan(amps, amount_per_month)
    tokyodenryoku = TokyoDenryoku.new(amps, amount_per_month)
    tokyodenryoku.tokyo_denryoku_plan
  end

  def looop_plan(amps, amount_per_month)
    looop = Looop.new(amps, amount_per_month)
    looop.looop_plan
  end

  def tokyo_gas_plan(amps, amount_per_month)
    tokyogas = TokyoGas.new(amps, amount_per_month)
    tokyogas.tokyo_gas_plan
  end

  # 新規電力会社の計算
  # def hoge_plan
  #   hoge = Hoge.new(amps, amount_per_month)
  #   hoge.hoge_plan
  # end
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
unless amount_per_month.positive?
  puts "入力された使用量が正しくありません。\n再度入力してください。"
  amount_per_month = gets.to_f.round
end

simulator = Simulator.new(amps, amount_per_month)
simulator.simulate
