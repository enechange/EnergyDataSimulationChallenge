class PagesController < ApplicationController
  def main
    @houses = House.all
  end

  def get_data
    data_set = {
      year_month: Dataset.pluck(:year, :month).uniq,
      production: Dataset.where(house_id: params['house_id']).order(:year, :month).group(:year,:month).sum(:energy_production).values,
      temperature: Dataset.group(:year,:month).average(:temperature).values,
      daylight: Dataset.group(:year,:month).average(:daylight).values,
      house: House.find(params['house_id'])
    }
    render json: data_set
  end
end
