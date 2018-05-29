class PagesController < ApplicationController
  def chart
    @houses = House.all
    @data_for_bar_chart = @houses.group(:city).count

    average_energy_productions_for_chrat =
     Energy.joins(:house).group('houses.city').group('houses.num_of_people')
     .average(:energy_production).map { |k, v| [k, v.to_i].flatten }

    @data_for_multiple_culumn_chart = [].tap do |arr|
      @houses.pluck(:city).uniq.each do |city|
        arr << Hash[name: city, data: []]
      end
    end

    average_energy_productions_for_chrat.each do |city, people, production|
      # city_row_fommat = {:name=>"London", :data=>[[people1, production1], [people2, production2]...}
      city_row = @data_for_multiple_culumn_chart.find { |i| i[:name] == city }
      city_row[:data].push([people, production]).sort!
    end
  end
end
