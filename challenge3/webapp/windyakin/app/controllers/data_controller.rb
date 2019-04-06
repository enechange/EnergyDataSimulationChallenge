class DataController < ApplicationController
  def index
    monthly_energies = Dataset.group(:year, :month).select(:year, :month).pluck(:year, :month).map do |year, month|
      monthly_energy = MonthlyEnergy.new(year: year, month: month)
      Dataset.where(year: year, month: month).preload(:house_datum).each { |data| monthly_energy.add_energy(city: data.house_datum.city, energy: data.energy_production) }
      monthly_energy
    end

    gon.monthly_energies = {
      data_attr_keys: monthly_energies.first.graph_keys,
      data_rows: monthly_energies.map(&:graph_values)
    }

    parsonaly_energies = HouseDatum.all.group_by(&:num_of_people).map do |num_of_people, house_data|
      parsonaly_energy = ParsonalyEnergy.new(num_of_people: num_of_people)
      house_data.each { |house_datum| parsonaly_energy.add_energy(house_datum.datasets.sum(:energy_production)) }
      parsonaly_energy
    end

    gon.parsonaly_energies = {
      data_attr_keys: parsonaly_energies.first.graph_keys,
      data_rows: parsonaly_energies.map(&:graph_values)
    }

    render :index
  end
end
