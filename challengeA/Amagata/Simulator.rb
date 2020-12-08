# class Simulator

#   def initialize(ampare, kilowatt_hour)
#     @ampare = ampare
#     @kilowatt_hour = kilowatt_hour
#     @array=[]
#   end

#   def calc_tepco
#     # 基本料金
#     tepco= { "10A" => "286", "15A" => "429", "20A" => "572","30A" => "858", "40A" => "1144", "50A" => "1430", "60A" => "1716" }
#     # kWhの条件と計算結果
#     if @kilowatt_hour < 120
#       sum_tepco = tepco["#{@ampare}A"].to_i + 19.88*@kilowatt_hour
#     elsif @kilowatt_hour >=120 && @kilowatt_hour < 300
#       sum_tepco = tepco["#{@ampare}A"].to_i + 26.48*@kilowatt_hour
#     else
#       sum_tepco = tepco["#{@ampare}A"].to_i + 30.57*@kilowatt_hour
#     end  
#     @sum_tepco= sum_tepco
#     # p @sum_tepco
#     @array << @sum_tepco
#     # p @array
#   end
  
#   def calc_loooop
#     # 計算結果
#     sum_loooop = 26.4*@kilowatt_hour
#     @sum_loooop= sum_loooop
#     # p @sum_loooop
#     @array << @sum_loooop
#     # p @array

#   end
  
#   def calc_tokyo_gas
#     # 基本料金
#     tepco= { "10A" => "286", "15A" => "429", "20A" => "572","30A" => "858", "40A" => "1144", "50A" => "1430", "60A" => "1716" }
#     tokyo_gas= { "30A" => "858", "40A" => "1144", "50A" => "1430", "60A" => "1716" }
#     # kWhの条件と計算結果
#     if @kilowatt_hour < 140
#       sum_tokyo_gas = tokyo_gas["#{@ampare}A"].to_i + 23.67*@kilowatt_hour
#     elsif @kilowatt_hour >=140 && @kilowatt_hour < 350
#       sum_tokyo_gas = tokyo_gas["#{@ampare}A"].to_i + 23.88*@kilowatt_hour
#     else
#       sum_tokyo_gas = tokyo_gas["#{@ampare}A"].to_i + 26.41*@kilowatt_hour
#     end  
#     @sum_tokyo_gas= sum_tokyo_gas
#     # p @sum_tokyo_gas
#     @array << @sum_tokyo_gas
#     # p @array
#   end

#   def simulate
#     lowest = @array.min
#     p lowest
#   end
# end

# 入力欄
# p "契約アンペアを入力してください(A)"
# ampere = gets.to_i
# p "1ヶ月の電力使用料を入力してください(kWh)"
# kilowatt_hour = gets.to_i
# simulator = Simulator.new(ampere,kilowatt_hour)
# simulator.calc_tepco
# simulator.calc_loooop
# simulator.calc_tokyo_gas
# simulator.simulate





class Calculator
  def initialize(ampare,kilowatt_hour)
    @ampare=ampare
    @kilowatt_hour=kilowatt_hour
  end
    # kWhの条件と計算結果
    # array_all = [tepco=> { "range1" => [@kilowatt_hour < 120,19.88], "range2" => [120,},loooop=>{ "range1" => "", "range2" => ""},tokyo_gas=>{ "range1" => 140, "range2" => 350}]

    def calculate
      info=Information.new
      arrays_all=[info.tepco,info.loooop,info.tokyo_gas]
      results=[]
    arrays_all.each do |array|
      i = 0
      if array[2][i]<= @kilowatt_hour && @kilowatt_hour < array[2][i+1]
        sum = info.basic_charge["#{@ampare}A"] + array[3][i]*@kilowatt_hour
      elsif @kilowatt_hour >=array[2][i+1] && @kilowatt_hour < array[2][i+2]
        sum = info.basic_charge["#{@ampare}A"] + array[3][i+1]*@kilowatt_hour
      else
        sum = info.basic_charge["#{@ampare}A"] + array[3][i+2]*@kilowatt_hour
      end  
      i += 1
      results << sum
    end
    @lowest = results.min
    order = results.index(@lowest)
    @campany = arrays_all[order][0]
    @plan= arrays_all[order][1]
  end
  
  def lowest
    @lowest
  end
  def campany
    @campany
  end
  def plan
    @plan
  end
end

class Information
  #東京の基本料金
  def basic_charge
    @basic_charge_tokyo= { "10A" => 286, "15A" => 429, "20A" => 572,"30A" => 858, "40A" => 1144, "50A" => 1430, "60A" => 1716 }
  end
  # 以下、[会社名、プラン名、レンジ、従量料金]
  def tepco
    @tepco = ["TEPCO","従量電灯B",[0,120,300],[19.88,26.48,30.57]]
  end
  
  def  loooop
    @loooop = ["Loooop","おうちプラン",[0,0,0],[26.40,26.40,26.40]]
  end

  def  tokyo_gas
    @tokyo_gas = ["Tokyo gas","ずっとも電気１",[0,140,350],[23.67,23.88,26.41]]
  end
end

# class UserInput
#   # 区分を入力
#   def ampare
#      p "契約アンペアを入力してください(A)"
#     gets.to_i
#   end
#   # 使用電力を入力
#   def kilowatt_hour
#     p "1ヶ月の電力使用料を入力してください(kWh)"
#     gets.to_i
#   end
# end

class Simulator
  def simulate
# ユーザー情報入力
  # 区分を入力
  p "契約アンペアを入力してください(A)"
  ampare = gets.to_i
# 使用電力を入力
  p "1ヶ月の電力使用料を入力してください(kWh)"
  kilowatt_hour= gets.to_i
# p @campany
calc=Calculator.new(ampare,kilowatt_hour)
calc.calculate
    result = { provider_name: "#{calc.campany}", plan_name: "#{calc.plan}", price: "#{calc.lowest}" }
    p result
  end
end
# simulator=Simulator.new







simulator = Simulator.new
simulator.simulate
