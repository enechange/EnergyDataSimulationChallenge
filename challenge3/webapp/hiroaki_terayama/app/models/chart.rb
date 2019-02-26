class Chart
  include ActiveModel::Model

  def self.fetch_energy_per_month(energy_records)
    ary = energy_records.pluck(:month, :energy_production)
    self.calc_ave(ary)
  end

  def self.calc_ave(ary)
    hash = (1..12).to_a.map.with_index { |v| [v, 0] }.to_h
    ary.each { |e| hash[e[0]] += e[1] }
    Hash[ hash.each { |key, value| hash[key] =  value / (ary.size / 12) }.sort ]
  end
end