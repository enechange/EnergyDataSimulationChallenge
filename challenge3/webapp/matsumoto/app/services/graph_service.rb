module GraphService
  module Cities
    def temperature_scatter
      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "EnergyProduction Scatter Graph on Temperature")
        energies = Energy.includes(:house).all.group_by { |e| e.house.city }
        energies.each do |city, energy|
          f.series({ name:  city.name,
                     yAxis: 0,
                     data:  energy.map { |e| [e.temperature, e.energy_production] } })
        end
        f.yAxis [{ title: { text: "Energy Production" } },]
        f.xAxis [{ title: { text: "Temperature(℃)" } }]
        f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
        f.chart({ type: 'scatter' })
      end
      chart
    end

    module_function :temperature_scatter
  end

  module Houses
    def person_num_pie
      chart = LazyHighCharts::HighChart.new('pie') do |f|
        f.chart({ :defaultSeriesType => "pie", :margin => [50, 200, 60, 170] })
        energies_by_person_num = Energy.includes(:house).all.group_by { |e| e.house.num_of_people }
        # ep[0]: num of persons
        # ep[1]: energy array of specific person num (sum up for pie graph)
        data                   = energies_by_person_num.map do |ep|
          ["#{ep[0]} persons", ep[1].reduce(0) { |sum, e| sum + e.energy_production }]
        end
        series                 = ({
            type: 'pie',
            name: "energy productions",
            data: data
        })
        f.series(series)
        f.options[:title][:text] = "Percentage of EnergyProductions of num of persons in house"
        f.legend(:layout => 'vertical', :style => { :left => 'auto', :bottom => 'auto', :right => '50px', :top => '100px' })
        f.plot_options(:pie => {
            :allowPointSelect => true,
            :cursor           => "pointer",
            :dataLabels       => {
                :enabled => true,
                :color   => "black",
                :style   => {
                    :font => "13px Trebuchet MS, Verdana, sans-serif"
                }
            }
        })
      end
      chart
    end

    module_function :person_num_pie
  end
end
