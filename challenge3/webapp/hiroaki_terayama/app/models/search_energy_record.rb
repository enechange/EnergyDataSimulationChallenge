class SearchEnergyRecord
  include ActiveModel::Model

  attr_accessor :city, :num_of_people, :has_child

  def search
    rel = EnergyRecord
    rel = rel.search_by_city(self.city) if self.city.present?
    rel = rel.search_by_num_of_people(self.num_of_people) if self.num_of_people.present?
    rel = rel.search_by_has_child(self.has_child) if self.has_child.present?
    rel
  end
end