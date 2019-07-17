# == Schema Information
#
# Table name: energies
#
#  id                :bigint           not null, primary key
#  label             :integer          not null
#  house_id          :bigint           not null
#  year              :integer          not null
#  month             :integer          not null
#  temperature       :decimal(3, 2)
#  daylight          :decimal(3, 2)    not null
#  energy_production :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Energy < ApplicationRecord
  belongs_to :house

  scope :with_house, -> { joins(:house) }
  scope :search_with_city_id , ->(city_id) { where(houses: {city_id: city_id}) }
  scope :order_date, -> { order(:year,:month) }
  scope :group_date, -> { group(:year, :month) }
  scope :average_energy_production, -> { average(:energy_production) }
  scope :average_city_energy , -> (city_id) {
    with_house.search_with_city_id(city_id).order_date.group_date.average_energy_production
  }
end
