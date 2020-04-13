# == Schema Information
#
# Table name: houses
#
#  id            :bigint           not null, primary key
#  firstname     :string(255)      not null
#  has_child     :boolean          not null
#  lastname      :string(255)      not null
#  num_of_people :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  city_id       :bigint
#
# Indexes
#
#  index_houses_on_city_id  (city_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#

class House < ApplicationRecord
  belongs_to :city
  has_many :datasets, dependent: :destroy

  scope :search_with_city_id, ->(city_id) { where(city_id: city_id) }
  scope :count_city, lambda {
    joins(:city).group(:city_id)
                .select('MAX(city_id) AS city_id, cities.name AS city_name, COUNT(*) AS count_all')
                .order(count_all: :desc)
  }
  scope :count_num_of_people, lambda {
    group(:num_of_people)
      .select('MAX(num_of_people) AS num_of_people, COUNT(*) AS count_all')
      .order(:num_of_people)
  }
  scope :count_has_child, lambda {
    group(:has_child)
      .select('houses.has_child, COUNT(*) AS count_all')
      .order(count_all: :desc)
  }
end
