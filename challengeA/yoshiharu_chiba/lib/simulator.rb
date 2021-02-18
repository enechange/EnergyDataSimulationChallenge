# # frozen_string_literal: true

require_relative './calculate'
require "json"

class Simulator
  def initialize(amps, amount_per_month)
    @amps = amps
    @amount_per_month = amount_per_month
  end

  def simulate
    calculate = Calculate.new(@amps, @amount_per_month)

    # 東京電力
    tokyo_denryoku_price = calculate.tokyo_denryoku_plan

    # ループでんき
    looop_price = calculate.looop_plan

    # 東京ガス
    tokyo_gas_price = calculate.tokyo_gas_plan if [30, 40, 50, 60].include?(@amps)

    # 新規電力会社
    # test_price = calculate.test_plan

    # test_price.to_sを末尾に追記
    prices = [tokyo_denryoku_price.to_s, looop_price.to_s, tokyo_gas_price.to_s]
    all_plans = File.open("json_plan.json") do |file|
      hash = JSON.load(file)
      hash.each_with_index do |plan, i|
        plan["price"] = prices[i]
      end
    end

    plans = []
    all_plans.each do |plan|
      unless plan["price"].empty?
        plans << plan
      end
    end
    p plans
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
unless amount_per_month.positive?
  puts "入力された使用量が正しくありません。\n再度入力してください。"
  amount_per_month = gets.to_f.round
end

simulator = Simulator.new(amps, amount_per_month)
simulator.simulate
