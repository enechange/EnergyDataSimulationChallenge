module ApplicationHelper
  
    #グラフ描画用配列の作成  
  def chart(energy_chart)
      chart = []
      energy_chart.each do |num|
        val1  =  "#{num.year}-#{num.month}"
        val2  =  num.energy_production。
        chart << [val1, val2]
      end
      return  chart
  end
  
end
