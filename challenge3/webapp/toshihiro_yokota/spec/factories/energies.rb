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
FactoryBot.define do
  factory :energy do
    label { 1 }
    house_id { 1 }
    year { 1 }
    month { 1 }
    temperature { "9.99" }
    daylight { "9.99" }
    energy_production { 1 }
  end
end
