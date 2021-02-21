# frozen_string_literal: true

require './calculate'
require 'json'

class Simulator
  def initialize(amps, amount_per_month)
    @amps = amps
    @amount_per_month = amount_per_month
  end

  # rubocop:disable Metrics/AbcSize
  def simulate
    calculate = Calculate.new(@amps, @amount_per_month)

    prices = []

    # 東京電力
    prices << calculate.tokyo_denryoku_plan

    # ループでんき
    prices << calculate.looop_plan

    # 東京ガス
    prices << calculate.tokyo_gas_plan if [30, 40, 50, 60].include?(@amps)

    # 新規電力会社
    # prices << calculate.test_plan

    json_file_path = File.expand_path('json_plan.json', __dir__)
    all_plans = File.open(json_file_path) do |file|
      JSON.load(file).each_with_index do |plan, i|
        plan['price'] = prices[i]
      end
    end

    plans = all_plans.map do |plan|
      plan unless plan['price'].nil?
    end.compact
    p plans
  end
  # rubocop:enable Metrics/AbcSize
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
