# == Schema Information
#
# Table name: datasets
#
#  id                :bigint           not null, primary key
#  label             :integer
#  house_id          :bigint           not null
#  year              :integer
#  month             :integer
#  temperature       :decimal(10, )
#  daylight          :decimal(10, )
#  energy_production :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Dataset < ApplicationRecord
  belongs_to :house
end
