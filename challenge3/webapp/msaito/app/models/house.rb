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
  def self.search(params)
    houses = House.all
    houses = houses.where("firstname LIKE :name or lastname LIKE :name", name: "%#{params[:name]}%") if params[:name].present?
    houses = houses.where("houses.city LIKE ?", "%#{params[:city]}%") if params[:city].present?
    houses = houses.where("houses.num_of_people LIKE ?", "%#{params[:num_of_people]}%") if params[:num_of_people].present?
    houses = houses.where("houses.has_child LIKE ?", "%#{params[:has_child]}%") if params[:has_child].present?
    return houses
  end
end
