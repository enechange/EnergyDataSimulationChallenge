# == Schema Information
#
# Table name: houses
#
#  id            :bigint           not null, primary key
#  firstname     :string(255)
#  lastname      :string(255)
#  city_id       :integer
#  num_of_people :integer
#  has_child     :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class House < ApplicationRecord
  belongs_to :city, class_name: 'City'
  has_many :energies, class_name: 'Energy', dependent: :destroy
end
