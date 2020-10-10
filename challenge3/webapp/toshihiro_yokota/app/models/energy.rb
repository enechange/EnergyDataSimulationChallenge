# == Schema Information
#
# Table name: energies
#
#  id                :bigint           not null, primary key
#  label             :integer
#  house_id          :integer
#  year              :integer
#  month             :integer
#  temperature       :decimal(10, )
#  daylight          :decimal(10, )
#  energy_production :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Energy < ApplicationRecord
  belongs_to :house, class_name: 'House'
  has_one :city, through: :house

  def self.dates
    distinct.pluck(:year, :month).map { |year, month| "#{year}-#{month}" }
  end
end
