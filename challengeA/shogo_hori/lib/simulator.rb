require 'csv'

class Simulator
  attr_reader :amps, :usage

  def initialize(amps, usage)
    @amps = amps
    @usage = usage
  end

  def simulate
    if !amps?(amps) && !number?(usage)
      puts "アンペアは10, 15, 20, 30, 40, 50, 60中から入力ください。\n使用量は0以上の数値で入力ください。"
    elsif !number?(usage)
      puts '使用量は0以上の数値で入力ください。'
    elsif !amps?(amps)
      puts 'アンペアは10, 15, 20, 30, 40, 50, 60中から入力ください。'
    else
      companies = Dir.glob('csv/*')
      plans = []

      companies.each do |d|
        inculdeAmps = CSV.table(File.expand_path("./#{d}/basicCharge.csv"))
        next unless inculdeAmps[:amps].include?(@amps)

        info = CSV.table(File.expand_path("./#{d}/info.csv"))
        plans << { provider_name: info[:provider_name][0], plan_name: info[:plan_name][0],
                   price: calculate(d).to_s }
      end

      plans.each do |plan|
        puts plan
      end
    end
  end

  def calculate(directory)
    basicCharge = basicCharge(CSV.read(File.expand_path("./#{directory}/basicCharge.csv")))
    usageCharge = usageUnitCharge(CSV.read(File.expand_path("./#{directory}/usageCharge.csv")))
    amount = @usage.round
    (basicCharge + usageCharge * amount).floor
  end

  private

  def number?(usage)
    (usage.to_s =~ /\A([1-9]\d*|0)(\.\d+)?\z/) != nil
  end

  def amps?(amps)
    [10, 15, 20, 30, 40, 50, 60].include?(amps)
  end

  def basicCharge(list)
    basicChargeList = list.map { |n| n.map(&:to_f) }
    basicChargeList.find { |charge| charge[0] == @amps }[1]
  end

  def usageUnitCharge(list)
    usageChargeList = list.map { |n| n.map(&:to_f) }
    if @usage.zero?
      @usage
    elsif usageChargeList.last[0] >= @usage
      usageChargeList.find { |charge| charge[0] < @usage && charge[1] >= @usage }[2]
    else
      usageChargeList.last[2]
    end
  end
end

simulator = Simulator.new(40, 180)
simulator.simulate
