# frozen_string_literal: true

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

