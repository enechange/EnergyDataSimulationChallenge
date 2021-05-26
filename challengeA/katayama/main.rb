require 'json'
require './simulator'
require './plan'

  # 契約アンペアを入力
  puts <<~TEXT
  契約しているアンペア数を入力して下さい。
  （例：30Aの場合は"30"と入力してください）
  TEXT

  while true
    print "アンペア数を入力 > "
    amp = gets.to_i
    break if [10, 15, 20, 30, 40, 50, 60].include?(amp)
    puts "10,15,20,30,40,50,60のいずれかを入力して下さい"
  end

  # 電気使用量を入力
  puts <<~TEXT
  次に1ヶ月の電気使用量(kWh)を入力してください。
  （例：300kWhの場合は"300"と入力してください）
  TEXT
  
  while true
    print "電気使用量を入力 > "
    kwh = gets.to_i
    break if kwh > 0
    puts "電気使用量は0以上の数値で入力してください"
  end

  # プランごとの設定値をJSONファイルから取得
  plan_objs = []
  File.open("plan_data.json") do |file|
    json_data = JSON.load(file, create_additions: true)
    
    # プランごとにインスタンスを生成する
    json_data["plan"].map do |plan_obj|
      plan_objs << Plan.new(plan_obj)
    end
  end

  # 見積もりシュミレーションを実行する
  simulator = Simulator.new(amp,kwh)
  simulator.simulate(plan_objs)