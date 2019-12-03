class Energy < ApplicationRecord
  include PluckToHash

  PLUCK_KEYS = %i[id label house_id year month temperature daylight energy_production].freeze
  COL_NAME   = %i[energy_production daylight temperature].freeze

  belongs_to :house

  validates :label, :house_id, :year, :month, :temperature, :daylight, :energy_production, presence: true
  validates :house_id, uniqueness: { scope: %i[year month] }


  scope :with_house, -> { joins(:house) }
  scope :by_city,    -> (city_name) { where(houses: { city: city_name }) }
  scope :by_month,   -> (month) { where(month: month) }

  scope :each_year_by_city, -> (year, city_name) {
    with_house.where(houses: { city: city_name }, year: year).group(:month)
  }
  scope :energy_each_year_by_city, -> (year, city_name) {
    each_year_by_city(year, city_name).sum(:energy_production)
  }

  scope :ave_energy_property_by_month, -> (month, city_name, column_name) {
    with_house.by_month(month).by_city(city_name).average(column_name)
  }

  scope :sum_energy_property_by_month, -> (month, city_name, column_name) {
    with_house.by_month(month).by_city(city_name).sum(column_name)
  }


  class << self
    def csv_header_converters
      -> (name) {
        {
          ID:               :id,
          Label:            :label,
          House:            :house_id,
          Year:             :year,
          Month:            :month,
          Temperature:      :temperature,
          Daylight:         :daylight,
          EnergyProduction: :energy_production
        }[name.to_sym] || raise
      }
    end

    def csv_converters
      nil
    end

    def target_years
      pluck(:year).uniq
    end

    def target_months
      pluck(:month).uniq.sort
    end

    def statistical_data_by_city(flag = nil)
      if flag == 'total'
        COL_NAME[0..1].map do |col_name|
          sum_property_by_month(col_name)
        end
      else
        COL_NAME.map do |col_name|
          ave_property_by_month(col_name)
        end
      end
    end

    def sum_property_by_month(col_name)
      House::CITIES.map do |city_name|
        datas_by_month = {}
        target_months.map do |target_month|
          datas_by_month.store(target_month, sum_energy_property_by_month(target_month, city_name, col_name))
        end
        {
          name: city_name,
          data: datas_by_month
        }
      end
    end

    def ave_property_by_month(col_name)
      House::CITIES.map do |city_name|
        datas_by_month = {}
        target_months.map do |target_month|
          datas_by_month.store(target_month, ave_energy_property_by_month(target_month, city_name, col_name))
        end
        {
          name: city_name,
          data: datas_by_month
        }
      end
    end

    def energy_each_years(selected_city)
      target_years.map do |target_year|
        {
          name: target_year,
          data: Energy.energy_each_year_by_city(target_year, selected_city)
        }
      end
    end
  end
end
