class HousesController < ApplicationController
  
  def index
    @house = House.new
    @city_name = City.all
    @houses = House.all
  end

  def show
    @house = House.find(params[:id])
    @city_name = City.all
    @years = Energy.count_year(params[:id])
    @target_dates = Energy.get_data(params[:id], @years)
    @energy = Energy.new
    @charts = []
    @month = []
    @daylight = []
    @energy_production = []
    
    @years.each do |y|
      (@target_dates.length).times do |i|
        if @target_dates[i][0].equal?(y.year) then
          @month << @target_dates[i][1]
          @daylight << @target_dates[i][2]
          @energy_production << @target_dates[i][3]
        end
      end
      @chart = get_chart_graph(y.year ,@month, @daylight, @energy_production)
      @charts << @chart
      @month = []
      @energy_production = []
      @daylight  = []
    end
  end

  def create
    @house = House.new(house_params)
    
    if @house.save
      flash[:success] = 'create house!!'
      redirect_to @house
    else
      flash[:danger] = 'not create house...'
      redirect_to houses_url
    end
  end

  def destroy
    @house = House.find(params[:id])
    @id = @house.id
    @house.destroy
    @energy = Energy.where(house_id: @id)
    @energy.each do |e|
      e.destroy
    end
    
    flash[:success] = 'Message'
    redirect_to houses_url
  end
  
  

  private
    def get_chart_graph(text, months, daylight, energy_production)
      @chart = LazyHighCharts::HighChart.new("graph") do |c|
        c.title(text: text)
        c.xAxis(categories: months)
        c.series(name: "energy_production", data: energy_production)
        c.series(name: "daylight", data: daylight, color: "red")
        c.chart(backgroundColor: 'lightgray')
      end
    end
    
    def house_params
      params.require(:house).permit(:firstname, :lastname, :num_of_people, :has_child, :city_id)
    end
end
