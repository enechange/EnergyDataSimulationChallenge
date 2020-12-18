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
    @info = [{ name: '東京電力エナジーパートナー', plan: '従量電灯Ｂ', base: tepco, rate: { 120 => 19.88, 300 => 26.48, 9**9 => 30.57 } },
             { name: 'Looopでんき', plan: 'おうちプラン', base: { 60 => 0 }, rate: { 9**9 => 26.40 } },
             { name: '東京ガス', plan: 'ずっとも電気１', base: togas, rate: { 140 => 23.67, 350 => 23.88, 9**9 => 26.41 } }]
  end

  def simulate
    calc
    @info.sort_by! { |a| a[:total_price] }
    puts "\n現在のプラン：#{@residents}人住まいでひと月#{@current_bills}円（#{@amp}A, #{@consumption}kWh）"
    puts '**************************************************************'
    @current_bills <= @info.first[:total_price] ? not_change_plan : change_plan
    suggest_amperage_change
  end

  def calc
    set_info
    @info.each { |plan| plan[:total_price] = total_price(plan) < 235 ? 235 : total_price(plan) }
  end

  def total_price(plan)
    return base_price(plan) if @consumption.zero?

    prev_key = 0
    plan[:rate].each do |key, value|
      return (base_price(plan) + value * @consumption).floor if @consumption > prev_key && @consumption <= key

      prev_key = key
    end
  end

  def base_price(plan)
    prev_key = 0
    plan[:base].each do |key, value|
      if @amp > prev_key && @amp <= key
        return @consumption.zero? ? (value * 0.5).floor : value
      end

      prev_key = key
    end
  end

  def not_change_plan
    puts "【最安値プラン】\n現在ご契約中のプランが最安値（ひと月あたり#{@current_bills}円）です！", '【その他プラン】'
    @info.each { |plan| puts "#{plan[:name]}#{plan[:plan]}はひと月あたり#{plan[:total_price]}円" }
  end

  def change_plan
    @info.each_with_index do |plan, idx|
      diff = @current_bills - plan[:total_price]
      comment = "#{plan[:name]}の#{plan[:plan]}はひと月あたり#{plan[:total_price]}円"
      if idx.zero?
        puts "【最安値プラン】\n#{comment}(#{diff}円お得！) \n【その他プラン】"
      else
        puts diff.positive? ? "#{comment}(#{diff}円お得！)\n" : "#{comment}(#{-diff}円高くなります)\n"
      end
    end
  end

  def suggest_amperage_change
    guideline = { 1 => 30, 2 => 30, 3 => 40, 4 => 50, 5 => 60 }
    return if (@residents <= 5 && guideline[@residents] == @amp) || @residents > 5

    puts "\n**************************************************************"
    puts "【見直しのご提案】\n #{@residents}人住まいのあなたは#{guideline[@residents]}Aがおすすめ！\nよくブレーカーが落ちる、なんか電気代が高いとお考えの方は見直しをご検討ください！"
    puts "※目安であり、部屋の大きさや使用している電気機器の種類や数、オール電化かどうかによって異なります。\n※集合住宅の場合、所有者等の承諾が必要な場合があります。\n"
  end

  def self.validate_value(comment, amps = nil)
    (1..2).each do |_n|
      $stdout.puts comment
      input = $stdin.gets.chomp
      return input.to_i if input =~ /^[0-9]+$/ && amps.nil?
      return input.to_i if amps&.include?(input.to_i)
    end
    $stdout.puts '【エラー】始めからやり直してください'
    exit! if __FILE__ == $PROGRAM_NAME
  end

  def self.residents_reciever
    puts "電気代のシミュレーションを行います！お得なプランを見つけましょう！\n何人でお住まいですか？半角数字で入力ください。（例:1人住まいの場合 \"1\"）"
    input = $stdin.gets.chomp
    input =~ /^[0-9]+$/ ? input.to_i : validate_value('お住まいの人数を半角数字で入力ください')
  end

  def self.bills_reciever
    puts '現在の月のご利用料金はいくらですか？半角数字で入力ください。（例:1000円の場合 "1000"）'
    input = $stdin.gets.chomp
    input =~ /^[0-9]+$/ ? input.to_i : validate_value('現在の月のご利用料金を半角数字で入力ください')
  end

  def self.consumption_reciever
    puts '現在の月のご使用量はいくらですか？半角数字で入力ください。（例:100kWhの場合 "100"）'
    input = $stdin.gets.chomp
    input =~ /^[0-9]+$/ ? input.to_i : validate_value('現在の月のご使用量半角数字で入力ください')
  end

  def self.amp_reciever
    regulated_amps = [10, 15, 20, 30, 40, 50, 60]
    puts 'お使いのアンペア数はいくつですか？半角数字で入力ください。（次の内からお選びください：10, 15, 20, 30, 40, 50, 60）'
    amp = $stdin.gets.chomp.to_i
    regulated_amps.include?(amp) ? amp : validate_value('10, 15, 20, 30, 40, 50, 60 の内から半角数字で入力ください', regulated_amps)
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
