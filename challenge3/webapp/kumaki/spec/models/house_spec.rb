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
#

require 'rails_helper'

RSpec.describe House, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
