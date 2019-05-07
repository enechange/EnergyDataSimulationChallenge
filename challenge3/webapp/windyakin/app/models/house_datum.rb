# == Schema Information
#
# Table name: house_data
#
#  id            :bigint(8)        not null, primary key
#  firstname     :string(255)      not null
#  lastname      :string(255)      not null
#  city          :string(255)      not null
#  num_of_people :integer          default(1), not null
#  has_child     :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class HouseDatum < ApplicationRecord
  has_many :datasets, class_name: 'Dataset', foreign_key: :house
end
