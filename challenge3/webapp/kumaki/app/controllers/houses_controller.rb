class HousesController < ApplicationController
  def index
    @count_city = House.joins(:city).group(:city_id)
                    .select('MAX(city_id) AS city_id, cities.name AS city_name, COUNT(*) AS count_all')
                    .order(count_all: :desc).map{ |house| [house.city_name, house.count_all] }.to_h
    @num_of_people = House.group(:num_of_people)
                          .select('MAX(num_of_people) AS num_of_people, COUNT(*) AS count_all')
                          .order(:num_of_people).map{ |house| [house.num_of_people, house.count_all] }.to_h
    @houses_for_pagination = House.includes(:city).page(params[:page]).per(10).order(:id)
  end

  def show
    @datasets = Dataset.includes(:house).search_with_house_id(params[:id]).order(:id)
    @average_dataset = Dataset.search_with_house_id(params[:id]).group(:house_id).select_average_dataset
    @houses = House.where(id: params[:id])
  end
end
