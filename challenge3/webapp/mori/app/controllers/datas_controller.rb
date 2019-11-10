class DatasController < ApplicationController

    def index
        @houses = House.all
        @sumLondon = location_sum_energy("London")
        @sumOxford = location_sum_energy("Oxford")
        @sumCambridge = location_sum_energy("Cambridge")
        #gon.data = [@sumLondon, @sumOxford, @sumCambridge]
        gon.dataLondon = [@sumLondon]
        gon.dataOxford = [@sumOxford]
        gon.dataCambridge = [@sumCambridge]
    end 
    
    def show
        @house = House.find(params[:id])
        @datas = Dataset.where(house_id: params[:id])
        @energy_production_2011 = get_energy_production(@datas, 2011)
        @daylight_2011 = get_daylight(@datas, 2011)
        @energy_production_2012 = get_energy_production(@datas, 2012)
        @daylight_2012 = get_daylight(@datas, 2012)
        @energy_production_2013 = get_energy_production(@datas, 2013)
        @daylight_2013 = get_daylight(@datas, 2013)
        months2011 = [7, 8, 9, 10, 11, 12]
        months2012 = [1,2,3,4,5,6,7,8,9,10,11,12]
        months2013 = [1,2,3,4,5,6]
        @chart2011 = get_chart_graph("Energy 2011", months2011, @energy_production_2011, @daylight_2011)
        @chart2012 = get_chart_graph("Energy 2012", months2012, @energy_production_2012, @daylight_2012)
        @chart2013 = get_chart_graph("Energy 2013", months2013, @energy_production_2013, @daylight_2013)
    end
    
    
    private
    
        def location_sum_energy(location)
            @sumEnergy = 0
            @sumHouse = House.where(city: location)
            @sumHouse.each do |user|
                user.datasets.each do |data|
                    @sumEnergy += data.energy_production
                end
            end
            @sumEnergy
        end
        
        def get_energy_production(datas, year)
            @energy = datas.where(year: year).pluck(:energy_production)
        end
        
        def get_daylight(datas, year)
            @daylight = datas.where(year: year).pluck(:daylight)
        end
        
        def get_chart_graph(text, months, energy_datas, daylight_data)
            @chart = LazyHighCharts::HighChart.new("graph") do |e|
                e.title(text: text)
                e.xAxis(categories: months)
                e.series(name: "energy_production", data: energy_datas)
                e.series(name: "daylight", data: daylight_data, color: "red")
                e.chart(backgroundColor: 'lightgray')
            end
        end
end
