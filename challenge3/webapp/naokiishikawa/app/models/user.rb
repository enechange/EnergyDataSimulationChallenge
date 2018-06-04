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

class User < ApplicationRecord
  self.primary_key = "user_id"
  has_many :energy_data

  as_enum :has_child, [:Yes, :No], map: :string, prefix: true, accessor: :whiny

end
