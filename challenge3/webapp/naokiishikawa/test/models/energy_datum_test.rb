# == Schema Information
#
# Table name: energy_data
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  year              :integer          not null
#  month             :integer          not null
#  temperature       :float(24)        not null
#  daylight          :float(24)        not null
#  energy_production :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class EnergyDatumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
