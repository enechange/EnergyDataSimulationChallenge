class HousesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
    :only => [:add, :update]
  include Analysis

  def index
    data = Energy.order(:id).sort_by{|i| i.temperature}
    category = data.map{|i| i.temperature}
    production = data.map{|i| i.energy_production}
    @regression1 = Analysis.regression(category, production)
    span = (category.min.floor..category.max.ceil).to_a

    @temperature = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => 'energy production')
      f.xAxis(:categories => span)
      f.series(:name => 'temperature',
               :data => span.map{|i| @regression1[:alpha]+@regression1[:beta]*i},
               :type => 'spline')
    end

    data = Energy.order(:id).sort_by{|i| i.daylight}
    category = data.map{|i| i.daylight}
    production = data.map{|i| i.energy_production}
    @regression2 = Analysis.regression(category, production)
    span = (category.min.floor..category.max.ceil).to_a.delete_if{|x| x%10 != 0 }

    @daylight = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => 'energy production')
      f.xAxis(:categories => span)
      f.series(:name => 'daylight',
               :data => span.map{|i| @regression2[:alpha]+@regression2[:beta]*i},
               :type => 'spline')
    end
  end

  def edit
    @house = House.find(params[:id])
  end

  def update
    house = House.find(params[:id])
    house.first_name = params[:first_name]
    house.last_name = params[:last_name]
    house.city = params[:city]
    house.num_of_people = params[:num_of_people]
    house.has_child = params[:has_child]
    house.save

    flash[:success] = "house data updated successfully"
    redirect_to :action => "detail", :id => house.id
  end

  def delete
    House.delete params[:id]

    flash[:success] = "house data deleted successfully"
    redirect_to :action => "list"
  end

  def new
  end

  def add
    house = House.new
    house.first_name = params[:first_name]
    house.last_name = params[:last_name]
    house.city = params[:city]
    house.num_of_people = params[:num_of_people]
    house.has_child = params[:has_child]
    house.save

    flash[:success] = "new house added successfully"
    redirect_to :action => "list"
  end

  def list
    @houses = House.page params[:page]
  end

  def detail
    @house = House.find(params[:id])
    @data = Energy.where :house_id => params[:id]
  end
end
