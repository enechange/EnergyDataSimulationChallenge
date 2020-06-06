class EnergiesController < ApplicationController
  def index
    case params[:target_select]
    when 'Daylight' then target = :daylight
    when 'Energy Production' then target = :energy_production
    when 'Temperature' then target = :temperature
    when 'Energry Production / Daylight' then target = :energy_production
    else target = :energy_production
    end

    case params[:cal_select]
    when 'Total' then cal = 'sum'
    when 'Per House' then cal = 'average'
    else cal = 'sum'
    end

    #都市別データ
    cities_list = ['London','Cambridge','Oxford']
    @graph_data = []
    cities_list.each do |city|
      data = Energy.joins(:house).select('energies.*,houses.*').where(houses: {city: city})
      eval("@#{city.downcase}_graph_data = data.group(:year_month).#{cal}(target)")

      data_y = Energy.joins(:house).select('energies.*,houses.*').where(houses: {city: city, has_child: true})
      eval("@#{city.downcase}_graph_data_y = data_y.group(:year_month).#{cal}(target)")

      data_n = Energy.joins(:house).select('energies.*,houses.*').where(houses: {city: city, has_child: false})
      eval("@#{city.downcase}_graph_data_n = data_n.group(:year_month).#{cal}(target)")

      # EnergyProduction / Daylightの場合のデータ集計
      if params[:target_select] == 'Energry Production / Daylight'
        eval("@daylight_data = data.group(:year_month).#{cal}(:daylight)")
        eval("@#{city.downcase}_graph_data = @#{city.downcase}_graph_data.map {|key,value| [key, value / @daylight_data[key]] }.to_h")

        eval("@daylight_data_y = data_y.group(:year_month).#{cal}(:daylight)")
        eval("@#{city.downcase}_graph_data_y = @#{city.downcase}_graph_data_y.map {|key,value| [key, value / @daylight_data_y[key]] }.to_h")

        eval("@daylight_data_n = data_n.group(:year_month).#{cal}(:daylight)")
        eval("@#{city.downcase}_graph_data_n = @#{city.downcase}_graph_data_n.map {|key,value| [key, value / @daylight_data_n[key]] }.to_h")
      end

      #デフォルト時のグラフデータ
      if params[:city_checkbox].nil? && params[:status_checkbox].nil?
        eval("@graph_data.push({name: \"#{city} all\", data: @#{city.downcase}_graph_data})")
      end

      #都市と世帯区分両方選択時のグラフデータ
      if params[:city_checkbox] && params[:status_checkbox]
        if params[:city_checkbox].include? city
          eval("@graph_data.push({name: \"#{city} all\", data: @#{city.downcase}_graph_data})") if params[:status_checkbox].include? 'All'
          eval("@graph_data.push({name: \"#{city} with child\", data: @#{city.downcase}_graph_data_y})") if params[:status_checkbox].include? 'With child'
          eval("@graph_data.push({name: \"#{city} without child\", data: @#{city.downcase}_graph_data_n})") if params[:status_checkbox].include? 'Without child'
        end
      end

      #世帯区分のみ選択時のグラフデータ
      if params[:city_checkbox].nil? && params[:status_checkbox]
        eval("@graph_data.push({name: \"#{city} all\", data: @#{city.downcase}_graph_data})") if params[:status_checkbox].include? 'All'
        eval("@graph_data.push({name: \"#{city} with child\", data: @#{city.downcase}_graph_data_y})") if params[:status_checkbox].include? 'With child'
        eval("@graph_data.push({name: \"#{city} without child\", data: @#{city.downcase}_graph_data_n})") if params[:status_checkbox].include? 'Without child'
      end

      #都市のみ選択時のグラフデータ
      if params[:city_checkbox] && params[:status_checkbox].nil?
        eval("@graph_data.push({name: \"#{city} all\", data: @#{city.downcase}_graph_data})") if params[:city_checkbox].include? city
      end
    end
  end
end
