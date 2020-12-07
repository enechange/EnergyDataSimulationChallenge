class Simulator
  def initialize(ampare, kilowatt_hour)
    @ampare = ampare
    @kilowatt_hour = kilowatt_hour
  end

  def simulate
    # if A < B && A < C
    #   p A
    # elsif B < A && B < C
    #   p B
    # else
    #   p C
    # end
  end
end



# 入力欄
p "契約アンペアを入力してください(A)"
ampere = gets.to_i
p "1ヶ月の電力使用料を入力してください(kWh)"
kilowatt_hour = gets.to_i
simulator = Simulator.new(ampere,kilowatt_hour)
simulator.simulate

# 基本料金
tepco= { "10A" => "286", "15A" => "429", "20A" => "572","30A" => "858", "40A" => "1144", "50A" => "1430", "60A" => "1716" }
loooop=0
tokyo_gas= { "30A" => "858", "40A" => "1144", "50A" => "1430", "60A" => "1716" }

