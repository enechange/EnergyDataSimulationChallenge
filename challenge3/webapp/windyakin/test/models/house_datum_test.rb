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

require 'test_helper'

class HouseDatumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
