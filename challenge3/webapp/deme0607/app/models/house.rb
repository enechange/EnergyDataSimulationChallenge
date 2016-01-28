class House < ActiveRecord::Base
  belongs_to :city
  has_many :energies
end
