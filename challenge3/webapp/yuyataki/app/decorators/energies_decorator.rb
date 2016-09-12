class EnergiesDecorator < Draper::CollectionDecorator
  def for_gchart
    [%w(Date Energy\ Production)] + object.map { |e| ["#{e.year}-#{e.month}", e.energy_production] }
  end

  def temperature_for_gchart
    [%w(Date Temperature)] + object.map { |e| ["#{e.year}-#{e.month}", e.temperature.to_s] }
  end
end
