class House < ApplicationRecord
  has_many :energies
  # after_find set_gotten_at

  # def set_gotten_at
  #   self.energies.map(&:gotten_at) = Time.local(self.energies.map(&:year),self.energies.map(&:month))
  # end
end
