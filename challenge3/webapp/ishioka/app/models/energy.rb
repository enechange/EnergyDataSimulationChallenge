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
end
