class ChartsController < ApplicationController

  def index
    energy_records = SearchEnergyRecord.search(search_params)
    @hash = Chart.fetch_energy_per_month(energy_records)
    render 'index', status: '200', formats: 'json', handlers: 'jbuilder'
  end

  private
    def search_params
      params.require(:q).permit(:city) if params[:q]
    end
end