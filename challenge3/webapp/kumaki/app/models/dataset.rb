# == Schema Information
#
# Table name: datasets
#
#  id                :bigint           not null, primary key
#  daylight          :decimal(5, 1)    not null
#  energy_production :integer          not null
#  label             :integer          not null
#  temperature       :decimal(3, 1)    not null
#  year_month        :date             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  house_id          :bigint
#
# Indexes
#
#  index_datasets_on_house_id  (house_id)
#
# Foreign Keys
#
#  fk_rails_...  (house_id => houses.id)
#

class Dataset < ApplicationRecord
  belongs_to :house

  scope :search_with_house_id, ->(house_id) { where(house_id: house_id) }
  scope :select_average, -> { select('AVG(datasets.temperature) AS temperature, AVG(datasets.daylight) AS daylight, AVG(datasets.energy_production) AS energy_production').take }
end
