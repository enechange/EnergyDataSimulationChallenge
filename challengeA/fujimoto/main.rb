# frozen_string_literal: true

require './lib/simulator'

puts "契約アンペア数を入力してください。"
puts "＊10A, 15A, 20A, 30A, 40A, 50A, 60Aの中から選択してください。"
puts "＊数字のみ入力してください"
amps = gets.to_i

unless [10, 15, 20, 30, 40, 50, 60].include?(amps)
  puts "契約アンペア数の入力に誤りがあります。"
  exit
end
 
puts "電力使用量(kWh)を入力してください"
puts "数字のみ入力してください。"
kWh = gets.to_i

if kWh <= 0
  puts "電力使用量(kWh)の入力に誤りがあります。"
  exit
end

simulator = Simulator.new(amps, kWh)
plan_list  = simulator.simulate

unless plan_list.empty?
  puts "以下のプランからお選びいただけます。"
  puts "========"
  plan_list.each do |plan|
    puts "会社名：#{plan[:provider_name]}"
    puts "プラン名：#{plan[:plan_name]}"
    puts "月額目安：#{plan[:price]}円"
    puts "========"
  end
else
  puts "ご案内できるプランはありません。"
end
