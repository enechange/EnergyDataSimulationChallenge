# == Schema Information
#
# Table name: data_sets
#
#  id                :bigint(8)        unsigned, not null, primary key
#  label             :integer          unsigned, not null
#  house_id          :bigint(8)        unsigned, not null
#  year              :integer          unsigned, not null
#  month             :integer          unsigned, not null
#  temperature       :float(24)        default(0.0), not null
#  daylight          :float(24)        default(0.0), not null
#  energy_production :integer          unsigned, not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_data_sets_on_label  (label)
#  index_data_sets_on_month  (month)
#  index_data_sets_on_year   (year)
#

class DataSet < ApplicationRecord
  belongs_to :house

  def collect_date
    @collect_date ||= Time.zone.parse("%04d/%02d/01" % [year, month])
  end
end
