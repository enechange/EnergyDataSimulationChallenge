# == Schema Information
#
# Table name: users
#
#  id            :integer          not null
#  user_id       :integer          not null, primary key
#  first_name    :string(255)      not null
#  last_name     :string(255)      not null
#  city          :string(255)      not null
#  num_of_people :integer          not null
#  has_child_cd  :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
