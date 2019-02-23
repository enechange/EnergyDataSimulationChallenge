class ChartsController < ApplicationController

  def index
    # TODO: ソートする
    energy_records = SearchEnergyRecord.new(search_params).search
    @hash = Chart.call_energy_per_month(energy_records)
    render 'index', status: '200', formats: 'json', handlers: 'jbuilder'
  end

  private
    def search_params
      params.require(:q).permit(:city, :num_of_people, :has_child) if params[:q]
    end
end