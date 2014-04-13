class House < ActiveRecord::Base
  has_many :energies
  belongs_to :city
end
