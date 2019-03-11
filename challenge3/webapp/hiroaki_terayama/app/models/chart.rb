class Chart
  include ActiveModel::Model

  def self.fetch_energy_per_month(energy_records)
    energy_records.group(:month).average(:energy_production)
  end
end