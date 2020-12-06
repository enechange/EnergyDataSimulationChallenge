class Simulator
  def initialize(residents, current_bills, consumption, amp)
    @residents = residents
    @current_bills = current_bills
    @consumption = consumption
    @amp = amp
  end

  def set_info
    tepco = { 10 => 286, 15 => 429, 20 => 572, 30 => 858, 40 => 1144, 50 => 1430, 60 => 1716 }
    togas = { 30 => 858, 40 => 1144, 50 => 1430, 60 => 1716 }
    # skgch = { 50 => 286, 60 => 429 }
    @plans = [
      { retailer: '東京電力エナジーパートナー', plan: '従量電灯B', base: tepco, rate: { 120 => 19.88, 300 => 26.48, 9**9 => 30.57 } },
      { retailer: 'Looopでんき', plan: 'おうちプラン', base: { 60 => 0 }, rate: { 9**9 => 26.40 } },
      { retailer: '東京ガス', plan: 'ずっとも電気１', base: togas, rate: { 140 => 23.67, 350 => 23.88, 9**9 => 26.41 } } # ,
      # { retailer: '関口電気', plan: '格安プラン', base: skgch, rate: { 9**9 => 10 } }
    ]
  end

  def simulate
    calc
    @plans.sort_by! { |a| a[:total_price] }
    puts '', "現在のプラン：#{@residents}人住まいでひと月#{@current_bills}円（#{@amp}A, #{@consumption}kWh）"
    puts '**************************************************************'
    @current_bills <= @plans.first[:total_price] ? no_change : change
    suggestion
  end

  def calc
    set_info
    @plans.each { |plan| plan[:total_price] = total_price(plan) }
  end

  def total_price(plan)
    total_price = base_price(plan)
    prev_key = 0
    plan[:rate].each do |key, value|
      if @consumption > prev_key && @consumption <= key
        total_price += value * @consumption
        break
      end
      prev_key = key
    end
    total_price.floor
  end

  def base_price(plan)
    base_price = 0
    prev_key = 0
    plan[:base].each do |key, value|
      if @amp > prev_key && @amp <= key
        base_price += value
        break
      end
      prev_key = key
    end
    base_price
  end

  def no_change
    puts "【最安値プラン】\n現在ご契約中のプランが最安値（ひと月あたり#{@current_bills}円）です！"
    puts '【その他プラン】'
    @plans.each do |plan|
      puts "#{plan[:retailer]}#{plan[:plan]}はひと月あたり#{plan[:total_price]}円"
    end
  end

  def change
    @plans.each_with_index do |plan, idx|
      diff = @current_bills - plan[:total_price]
      if idx.zero?
        puts "【最安値プラン】\n #{plan[:retailer]}の#{plan[:plan]}はひと月あたり#{plan[:total_price]}円(#{diff}円お得！)", '【その他プラン】'
      else
        puts "#{plan[:retailer]}の#{plan[:plan]}はひと月あたり#{plan[:total_price]}円(#{diff}円お得！)\n" if diff.positive?
        puts "#{plan[:retailer]}の#{plan[:plan]}はひと月あたり#{plan[:total_price]}円(#{-diff}円高くなります)\n" if diff.negative?
      end
    end
  end

  def suggestion
    guideline = { 1 => 30, 2 => 30, 3 => 40, 4 => 50, 5 => 60 }
    return if (@residents <= 5 && guideline[@residents] == @amp) || @residents > 5

    puts '', '**************************************************************'
    puts "【見直しのご提案】\n #{@residents}人住まいのあなたは#{guideline[@residents]}Aがおすすめ！"
    puts 'よくブレーカーが落ちる、なんか電気代が高い、とお考えの方は見直しをご検討ください！'
    puts '※目安であり、部屋の大きさや使用している電気機器の種類や数、オール電化かどうかによって異なります。'
    puts "※集合住宅の場合、所有者等の承諾が必要な場合があります。\n"
  end

  ## Standard input/output
  def self.valid_value?(input, comment)
    (1..2).each do |_n|
      return input if input.positive?

      $stdout.puts comment + '半角数字で入力ください'
      input = $stdin.gets.chomp.to_i
    end
    input.positive? ? input : exit
  rescue SystemExit
    $stdout.puts '【エラー】始めからやり直してください'
    exit! if __FILE__ == $PROGRAM_NAME
  end

  def self.residents_reciever
    puts '電気代のシミュレーションを行います！お得なプランを見つけましょう！'
    puts '何人でお住まいですか？半角数字で入力ください。（例:1人住まいの場合 "1"）'
    residents = $stdin.gets.chomp.to_i
    residents = valid_value?(residents, 'お住まいの人数を')
    residents
  end

  def self.bills_reciever
    puts '現在の月のご利用料金はいくらですか？半角数字で入力ください。（例:1000円の場合 "1000"）'
    current_bills = $stdin.gets.chomp.to_i
    current_bills = valid_value?(current_bills, '現在の月のご利用料金を')
    current_bills
  end

  def self.consumption_reciever
    puts '現在の月のご使用量はいくらですか？半角数字で入力ください。（例:100kWhの場合 "100"）'
    consumption = $stdin.gets.chomp.to_i
    consumption = valid_value?(consumption, '現在の月のご使用量')
    consumption
  end

  def self.amp_reciever
    puts 'お使いのアンペア数はいくつですか？半角数字で入力ください。（次の内からお選びください：10, 15, 20, 30, 40, 50, 60）'
    amp = $stdin.gets.chomp.to_i
    (1..2).each do |_n|
      return amp if [10, 15, 20, 30, 40, 50, 60].include?(amp)

      $stdout.puts '10, 15, 20, 30, 40, 50, 60 の内から半角数字で入力ください'
      amp = $stdin.gets.chomp.to_i
    end
    [10, 15, 20, 30, 40, 50, 60].include?(amp) ? amp : exit
  rescue SystemExit
    $stdout.puts '【エラー】始めからやり直してください'
    exit! if __FILE__ == $PROGRAM_NAME
  end
end

if __FILE__ == $PROGRAM_NAME
  residents = Simulator.residents_reciever
  current_bills = Simulator.bills_reciever
  consumption = Simulator.consumption_reciever
  amp = Simulator.amp_reciever
  answer = Simulator.new(residents, current_bills, consumption, amp)
  answer.simulate
end
