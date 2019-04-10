# frozen_string_literal: true

class House < ApplicationRecord
  belongs_to :city
  # NOTE: 日照量と発電量など単体でも有益の可能性があるので dependent: :nullify
  has_many :monthly_house_energy_productions, dependent: :nullify

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :num_of_people, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :has_child, inclusion: { in: [true, false] }

  MonthlyHouseEnergyProduction::TARGET_AGGREGATION_COLUMNS.each do |target_column|
    # def total_maximum_temperature
    # def total_maximum_daylight
    # def total_maximum_energy_production
    define_method("total_maximum_#{target_column}") do
      Rails.cache.fetch "house_total_maximum_#{target_column}_for_#{id}", expires_in: 1.month do
        MonthlyHouseEnergyProduction.where(house: id).maximum(target_column)
      end
    end

    # def total_mode_temperature
    # def total_mode_daylight
    # def total_mode_energy_production
    define_method("total_mode_#{target_column}") do
      Rails.cache.fetch "house_total_mode_#{target_column}_for_#{id}", expires_in: 1.month do
        ActiveRecord::Base.connection.execute("SELECT mode() WITHIN GROUP (ORDER BY #{target_column}) FROM monthly_house_energy_productions WHERE house_id = #{id}").to_a[0]['mode']
      end
    end

    # def total_average_temperature
    # def total_average_daylight
    # def total_average_energy_production
    define_method("total_average_#{target_column}") do
      Rails.cache.fetch "house_total_average_#{target_column}_for_#{id}", expires_in: 1.month do
        MonthlyHouseEnergyProduction.where(house: id).average(target_column).round(1)
      end
    end

    # def total_median_temperature
    # def total_median_daylight
    # def total_median_energy_production
    define_method("total_median_#{target_column}") do
      Rails.cache.fetch "house_total_median_#{target_column}_for_#{id}", expires_in: 1.month do
        MonthlyHouseEnergyProduction.where(house: id).median(target_column)
      end
    end

    # def total_minimum_temperature
    # def total_minimum_daylight
    # def total_minimum_energy_production
    define_method("total_minimum_#{target_column}") do
      Rails.cache.fetch "house_total_minimum_#{target_column}_for_#{id}", expires_in: 1.month do
        MonthlyHouseEnergyProduction.where(house: id).minimum(target_column)
      end
    end
    # def monthly_maximum_temperatures
    # def monthly_maximum_daylights
    # def monthly_maximum_energy_productions
    define_method("monthly_maximum_#{target_column}s") do
      Rails.cache.fetch "house_monthly_maximum_#{target_column}s_for_#{id}", expires_in: 1.month do
        MonthlyHouseEnergyProduction.where(house: id).group(:year, :month).maximum(target_column)
      end
    end

    # def monthly_mode_temperatures
    # def monthly_mode_daylights
    # def monthly_mode_energy_productions
    define_method("monthly_mode_#{target_column}s") do
      Rails.cache.fetch "house_monthly_mode_#{target_column}s_for_#{id}", expires_in: 1.month do
        ActiveRecord::Base.connection.execute("SELECT mode() WITHIN GROUP (ORDER BY #{target_column}) FROM monthly_house_energy_productions WHERE house_id = #{id}").to_a[0]['mode']
      end
    end

    # def monthly_average_temperatures
    # def monthly_average_daylights
    # def monthly_average_energy_productions
    define_method("monthly_average_#{target_column}s") do
      Rails.cache.fetch "house_monthly_average_#{target_column}s_for_#{id}", expires_in: 1.month do
        MonthlyHouseEnergyProduction.where(house: id).group(:year, :month).average(target_column)
      end
    end

    # def monthly_median_temperatures
    # def monthly_median_daylights
    # def monthly_median_energy_productions
    define_method("monthly_median_#{target_column}s") do
      Rails.cache.fetch "house_monthly_median_#{target_column}s_for_#{id}", expires_in: 1.month do
        MonthlyHouseEnergyProduction.where(house: id).group(:year, :month).median(target_column)
      end
    end

    # def monthly_minimum_temperatures
    # def monthly_minimum_daylights
    # def monthly_minimum_energy_productions
    define_method("monthly_minimum_#{target_column}s") do
      Rails.cache.fetch "house_monthly_minimum_#{target_column}s_for_#{id}", expires_in: 1.month do
        MonthlyHouseEnergyProduction.where(house: id).group(:year, :month).minimum(target_column)
      end
    end
  end

  class << self
    MonthlyHouseEnergyProduction::TARGET_AGGREGATION_COLUMNS.each do |target_column|
      # def self.total_maximum_temperature
      # def self.total_maximum_daylight
      # def self.total_maximum_energy_production
      define_method("total_maximum_#{target_column}") do
        Rails.cache.fetch "house_total_maximum_#{target_column}_for_all", expires_in: 1.month do
          MonthlyHouseEnergyProduction.maximum(target_column)
        end
      end

      # def self.total_mode_temperature
      # def self.total_mode_daylight
      # def self.total_mode_energy_production
      define_method("total_mode_#{target_column}") do
        Rails.cache.fetch "house_total_mode_#{target_column}_for_all", expires_in: 1.month do
          ActiveRecord::Base.connection.execute("SELECT mode() WITHIN GROUP (ORDER BY #{target_column}) FROM monthly_house_energy_productions").to_a[0]['mode']
        end
      end

      # def self.total_average_temperature
      # def self.total_average_daylight
      # def self.total_average_energy_production
      define_method("total_average_#{target_column}") do
        Rails.cache.fetch "house_total_average_#{target_column}_for_all", expires_in: 1.month do
          MonthlyHouseEnergyProduction.average(target_column).round(1)
        end
      end

      # def self.total_median_temperature
      # def self.total_median_daylight
      # def self.total_median_energy_production
      define_method("total_median_#{target_column}") do
        Rails.cache.fetch "house_total_median_#{target_column}_for_all", expires_in: 1.month do
          MonthlyHouseEnergyProduction.median(target_column)
        end
      end

      # def self.total_minimum_temperature
      # def self.total_minimum_daylight
      # def self.total_minimum_energy_production
      define_method("total_minimum_#{target_column}") do
        Rails.cache.fetch "house_total_minimum_#{target_column}_for_all", expires_in: 1.month do
          MonthlyHouseEnergyProduction.minimum(target_column)
        end
      end
      # def self.monthly_maximum_temperatures
      # def self.monthly_maximum_daylights
      # def self.monthly_maximum_energy_productions
      define_method("monthly_maximum_#{target_column}s") do
        Rails.cache.fetch "house_monthly_maximum_#{target_column}s_for_all", expires_in: 1.month do
          MonthlyHouseEnergyProduction.group(:year, :month).maximum(target_column)
        end
      end

      # def self.monthly_mode_temperatures
      # def self.monthly_mode_daylights
      # def self.monthly_mode_energy_productions
      define_method("monthly_mode_#{target_column}s") do
        Rails.cache.fetch "house_monthly_mode_#{target_column}s_for_all", expires_in: 1.month do
          ActiveRecord::Base.connection.execute("SELECT mode() WITHIN GROUP (ORDER BY #{target_column}) FROM monthly_house_energy_productions GROUP BY year ASC, month ASC").to_a[0]['mode']
        end
      end

      # def self.monthly_average_temperatures
      # def self.monthly_average_daylights
      # def self.monthly_average_energy_productions
      define_method("monthly_average_#{target_column}s") do
        Rails.cache.fetch "house_monthly_average_#{target_column}s_for_all", expires_in: 1.month do
          MonthlyHouseEnergyProduction.group(:year, :month).average(target_column)
        end
      end

      # def self.monthly_median_temperatures
      # def self.monthly_median_daylights
      # def self.monthly_median_energy_productions
      define_method("monthly_median_#{target_column}s") do
        Rails.cache.fetch "house_monthly_median_#{target_column}s_for_all", expires_in: 1.month do
          MonthlyHouseEnergyProduction.group(:year, :month).median(target_column)
        end
      end

      # def self.monthly_minimum_temperatures
      # def self.monthly_minimum_daylights
      # def self.monthly_minimum_energy_productions
      define_method("monthly_minimum_#{target_column}s") do
        Rails.cache.fetch "house_monthly_minimum_#{target_column}s_for_all", expires_in: 1.month do
          MonthlyHouseEnergyProduction.group(:year, :month).minimum(target_column)
        end
      end
    end
  end
end
