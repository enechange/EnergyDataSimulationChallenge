# frozen_string_literal: true

class MonthlyHouseEnergyProduction < ApplicationRecord
  scope :order_by_month, -> { order(year: :asc, month: :asc) }
  scope :group_by_month, -> { group(:year, :month) }
  belongs_to :house

  validates :label, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :year, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :month, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :temperature, presence: true, numericality: { greater_than: 0 }
  validates :daylight, presence: true, numericality: { greater_than: 0 }
  validates :energy_production, presence: true, numericality: { greater_than: 0, only_integer: true }

  TARGET_AGGREGATION_COLUMNS = %i[temperature daylight energy_production].freeze
end
