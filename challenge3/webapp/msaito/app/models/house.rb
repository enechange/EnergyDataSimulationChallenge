# == Schema Information
#
# Table name: houses
#
#  id            :bigint           not null, primary key
#  firstname     :string(255)
#  lastname      :string(255)
#  city          :string(255)
#  num_of_people :integer
#  has_child     :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class House < ApplicationRecord
  has_many :datasets
  CITY_ARRAY = ['London','Cambridge','Oxford']
end
