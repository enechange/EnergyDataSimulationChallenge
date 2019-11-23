class StaticPagesController < ApplicationController
  def top; end

  def all
    @all_energy = [scatter_params(EnergyDetail.all_data)]
  end

  def city
    @all_energy = []
    cities = %w[cambridge london oxford]

    cities.each do |city|
      @all_energy << scatter_params(EnergyDetail.city_data(city))
    end
    render 'all.json.jbuilder'
  end

  def num_of_people
    @all_energy = []
    nums = [2, 3, 4, 5, 6]

    nums.each do |num|
      @all_energy << scatter_params(EnergyDetail.num_of_people_data(num))
    end
    render 'all.json.jbuilder'
  end

  private

    def scatter_params(data_array)
      {
        label:           data_array[0],
        backgroundColor: data_array[1],
        borderColor:     data_array[2],
        data:            data_array[3]
      }
    end
end
