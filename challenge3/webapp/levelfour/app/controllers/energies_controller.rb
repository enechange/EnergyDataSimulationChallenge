class EnergiesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
    :only => [:add, :update]

  def index
    set = Energy.order :id
    @category = set.map{|i| House.find(i.house_id).city }.uniq!
    @data = []
    @category.each{|c|
      d = set.select{|r| r.house.city == c}
      @data << d.map{|i| i.energy_production / d.length}.inject(:+)
    }

    @graph1 = LazyHighCharts::HighChart.new("graph") do |f|
      f.chart(:type => "column")
      f.title(:text => "energy production per one house in each city")
      f.xAxis(:categories => @category)
      f.series(:name => "city", :data => @data)
    end

    @category = set.map{|i| House.find(i.house_id).num_of_people}.uniq!
    @data = []
    @category.each{|c|
      d = set.select{|r| r.house.num_of_people == c}
      @data << d.map{|i| i.energy_production}.inject(:+) / d.length
    }

    @graph2 = LazyHighCharts::HighChart.new("graph") do |f|
      f.chart(:type => "column")
      f.title(:text => "relationship between num_of_people and energy production per one house")
      f.xAxis(:categories => @category)
      f.series(:name => "num_of_people", :data => @data)
    end
  end

  def new
  end

  def add
    data = Energy.new

    data.house_id = params[:house_id]
    data.label = Energy.where(:house_id => params[:house_id]).pluck(:label).max + 1
    data.month = Date.new(params[:year].to_i, params[:month].to_i)
    data.temperature = params[:temperature]
    data.daylight = params[:daylight]
    data.energy_production = params[:energy_production]
    data.save

    flash[:success] = "house data updated successfully"
    redirect_to :controller => "houses",
      :action => "detail", :id => params[:house_id]
  end

  def edit
    @data = Energy.find params[:id]
  end

  def update
    data = Energy.find params[:id]

    data.month = Date.new(params[:year].to_i, params[:month].to_i)
    data.temperature = params[:temperature]
    data.daylight = params[:daylight]
    data.energy_production = params[:energy_production]
    data.save

    flash[:success] = "house data updated successfully"
    redirect_to :action => "detail", :id => params[:id]
  end

  def delete
    Energy.delete params[:id]

    flash[:success] = "house data deleted successfully"
    redirect_to :action => "list"
  end

  def list
    @data = Energy.page params[:page]
  end

  def detail
    @data = Energy.find params[:id]
  end
end
