class CitiesController < ApplicationController
  def index
    @cities = City.all
    @count_city = House.count_city.map { |house| [house.city_name, house.count_all] }.to_h
  end

  def show
    @cities = City.where(id: params[:id])
    @count_num_of_people = House.search_with_city_id(params[:id])
                                .count_num_of_people.map { |house| [house.num_of_people, house.count_all] }.to_h
    @count_has_child = House.search_with_city_id(params[:id]).count_has_child
    @datasets_group_by_time = Dataset.search_with_city_id(params[:id])
                                     .select_average_datasets_group_by(:year_month)
    @average_dataset = Dataset.search_with_city_id(params[:id]).select_average_dataset
    @datasets = Dataset.search_with_city_id(params[:id]).includes(:house)
    @datasets_for_pagination = @datasets.page(params[:page]).per(10)
  end
end
