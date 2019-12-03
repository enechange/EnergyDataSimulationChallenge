class HousesController < ApplicationController

  def index
    @selected_city     = params[:city] ||= 'London'
    @energy_each_years = Energy.energy_each_years(@selected_city)

    @children_by_city = House.children_by_city

    house_columns = House::PLUCK_KEYS
    @houses       = House.pluck_to_hash(house_columns)
  end

  private

  def house_params
    params.require(:house).permit(
      :city
    )
  end
end
