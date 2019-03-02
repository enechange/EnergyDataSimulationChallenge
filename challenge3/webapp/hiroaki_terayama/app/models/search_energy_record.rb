class SearchEnergyRecord

  def self.search(args)
    rel = EnergyRecord
    rel = rel.search_by_city(args['city']) if args && args['city'].present?
    rel
  end
end