class Chart
  include ActiveModel::Model

  def self.call_energy_per_month(energy_records)
    ary = energy_records.pluck(:month, :energy_production)
    self.calc_ave(ary)
  end

  def self.calc_ave(ary)
    hash = {}
    ary.each do |e|
      if hash.has_key?(e[0])
        hash[e[0]] += e[1]
      else
        hash[e[0]] = e[1]
      end
    end
    Hash[ hash.each { |key, value| hash[key] =  value / (ary.size / 12) }.sort ]
  end
end