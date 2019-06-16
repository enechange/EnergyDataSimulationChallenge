# == Schema Information
#
# Table name: houses
#
#  id            :bigint           not null, primary key
#  first_name    :string           not null
#  last_name     :string           not null
#  city_id       :bigint           not null
#  num_of_people :integer          not null
#  has_child     :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :house do
    
  end
end
