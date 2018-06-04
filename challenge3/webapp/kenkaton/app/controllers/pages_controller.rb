class PagesController < ApplicationController
  def chart
    @houses = House.all
    @data_for_bar_chart = @houses.group(:city).count

    # multiple_chart_format ==
    # [{name: "London",    data: [[people1, production1], [people2, production2],...]},
    #  {name: "Cambridge", data: [[people1, production1], [people2, production2],...]},
    #  {name: "Oxford",    data: [[people1, production1], [people2, production2],...]}]
    @multiple_culumn_chart_data = @houses.group(:city).pluck(:city).map { |city| Hash[name: city, data: []] }

    average_energy_productions =
      Energy.joins(:house).group('houses.city').group('houses.num_of_people').average(:energy_production)

    @multiple_culumn_chart_data.map do |city|
      (2..House.max_people).each do |num|
        if average_energy_productions[[city[:name], num]].blank?
          city[:data] << [num, 0]
        else
          city[:data] << [num, average_energy_productions[[city[:name], num]].to_i]
        end
      end
    end
  end
end
