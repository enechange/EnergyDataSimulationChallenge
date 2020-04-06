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

FactoryBot.define do
  factory :house do
    firstname "MyString"
  end
end
