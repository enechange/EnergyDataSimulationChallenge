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
require 'rails_helper'

RSpec.describe Energy, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
