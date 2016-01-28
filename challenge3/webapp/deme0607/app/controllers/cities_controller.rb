class CitiesController < ApplicationController
  def index
    @cities = City.all.order(:id)
  end

  def energies
    energies = Energy.joins(:house)
      .where(houses: {city_id: params[:city_id]})
      .order(:house_id).order(:label)

    respond_to do |format|
      format.json do
        render json: energies.to_json
      end
    end
  end
end
