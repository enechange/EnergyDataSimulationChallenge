class MonthlyEnergy
  include ActiveModel::Model

  attr_accessor :year, :month
  attr_reader :energies

  def initialize(*args)
    super(*args)
    @energies ||= {}
  end

  def position
    "#{@year}/#{@month}"
  end

  def graph_keys
    {
      position: 'string'
    }.merge(@energies.keys.map { |city| [city.to_sym, 'number'] }.to_h)
  end

  def graph_values
    [position].concat(@energies.values)
  end

  def add_energy(city:, energy:)
    @energies[city] ||= 0
    @energies[city] += energy
  end
end
