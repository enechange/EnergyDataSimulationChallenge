class StaticsController < ApplicationController
  before_action :search
  helper_method :sort_column, :sort_direction 

  def index
    @houses = House.search(params).page(params[:page]).per(10).order(sort_column + " " + sort_direction)
  end

  def show
    @house = House.find(params[:id])
    @datas = @house.datasets.pluck(:year,:month, :temperature, :daylight, :energy_production)
    @dates = @house.datasets.pluck(:year,:month)
    @temperatures = @datas.map(&:third)
    @daylights = @datas.map(&:fourth)
    @energyproductions = @datas.map(&:fifth)
  end

 private

  def search
    @houses = House.search(params.permit!)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    House.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
end
