require './lib/simulator'

AVAILABLE_AMP = [10, 15, 20, 30, 40, 50, 60]

puts '契約アンペア数を数字のみで入力してください。'
puts "#{AVAILABLE_AMP}の中から選択してください。"
contract_amp = gets.to_i

unless AVAILABLE_AMP.include?(contract_amp)
  puts '契約アンペア数の入力が不正です。'
  exit
end

puts '電力使用量(kWh)を整数のみで入力してください'
power_usage = gets.to_i

if power_usage.negative?
  puts '電力使用量(kWh)は0以上を入力してください。'
  exit
end

simulator = Simulator.new(contract_amp, power_usage)
plan_lists = simulator.simulate

if plan_lists.empty?
  puts '条件に一致するプランはありません。'
else
  puts 'ご入力いただいた条件での見積もり結果は以下の通りです。'
  puts "契約アンペア：#{contract_amp}(A), 電力使用量：#{power_usage}(kwh)"
  puts '================================================'
  plan_lists.each do |plan|
    puts "プロバイダー名：#{plan[:provider_name]}"
    puts "プラン名：#{plan[:plan_name]}"
    puts "月額料金：#{plan[:price]}円"
    puts '================================================'
  end
end
