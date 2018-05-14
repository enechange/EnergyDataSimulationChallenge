module Apis
  class EnergyController < ApplicationController

    JOIN_COLUMS = %w{ users.id energy_data.year energy_data.month energy_data.temperature energy_data.daylight energy_data.energy_production }.join(',').freeze

    def energy_production
      user_id = params[:user_id]
      year = params[:year]
      energy_list = User.joins(:energy_data).where(user_id: user_id, energy_data: { year: year }).select(JOIN_COLUMS).as_json
      result = { labels: [], data: [] }
      energy_list.each do |energy|
        result[:labels] << to_date(energy_data: energy)
        result[:data] << energy['energy_production']
      end
      render json: result
    end

    def average
      result = { years: [], average: {} }
      energy_data = {}
      EnergyDatum.all.as_json.each { |energy|
        date = to_date(energy_data: energy)
        energy_data[date] = [] if energy_data[date].blank?
        energy_data[date] << energy['energy_production']
        result[:years] << energy['year'] unless result[:years].include?(energy['year'])
      }
      result[:years] = result[:years].sort
      energy_data.each do |date, energy_list|
        result[:average][date] = (energy_list.sum / energy_list.size).to_i
      end
      render json: result
    end

    private

    def to_date(energy_data: {})
      "#{energy_data['year']}/#{energy_data['month']}"
    end

  end
end
