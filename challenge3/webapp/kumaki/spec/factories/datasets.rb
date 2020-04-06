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

FactoryBot.define do
  factory :dataset do
    daylight { 178.9 }
    energy_production { 740 }
    label { 0 }
    temperature { 26.2 }
    year_month { 2011-07-01 }
    association :house
  end
end
