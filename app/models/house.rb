# == Schema Information
#
# Table name: houses
#
#  id            :bigint(8)        unsigned, not null, primary key
#  firstname     :string(255)      not null
#  lastname      :string(255)      not null
#  city          :string(255)      not null
#  num_of_people :integer          default(1), unsigned, not null
#  has_child     :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_houses_on_city  (city)
#

class House < ApplicationRecord
end
