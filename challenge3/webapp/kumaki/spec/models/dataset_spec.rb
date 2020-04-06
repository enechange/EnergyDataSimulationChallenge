# == Schema Information
#
# Table name: datasets
#
#  id                :bigint           not null, primary key
#  daylight          :decimal(5, 1)    not null
#  energy_production :integer          not null
#  label             :integer          not null
#  month             :integer          not null
#  temperature       :decimal(3, 1)    not null
#  year              :integer          not null
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

require 'rails_helper'

RSpec.describe Dataset, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
