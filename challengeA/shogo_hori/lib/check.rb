require_relative './plan'

class Check
  attr_reader :amps, :usage

  def initialize(amps, usage)
    @amps = amps
    @usage = usage
  end

  def input_check
    if !amps?(@amps) && !number?(@usage)
      puts "アンペアは#{all_amps}中から入力ください。\n使用量は0以上の数値で入力ください。"
    elsif !number?(@usage)
      puts '使用量は0以上の数値で入力ください。'
    elsif !amps?(@amps)
      puts "アンペアは#{all_amps}中から入力ください。"
    else
      1
    end
  end

  private

  def number?(usage)
    (usage.to_s =~ /\A([1-9]\d*|0)(\.\d+)?\z/) != nil
  end

  def amps?(amps)
    all_amps.include?(amps)
  end

  def all_amps
    amps_array = []
    Plan::ALLPLANS.each do |plan|
      amps_array << plan.basic_charge_list[:amps]
    end
    amps_array.flatten.uniq
  end
end
