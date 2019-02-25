class SearchEnergyRecord
  include ActiveModel::Model

  attr_accessor :city

  def search
    rel = EnergyRecord
    rel = rel.search_by_city(self.city) if self.city.present?
    rel
  end
end