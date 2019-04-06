class ParsonalyEnergy
  include ActiveModel::Model

  attr_accessor :num_of_people
  attr_reader :energy

  def initialize(*args)
    super(*args)
    @energy = 0
    @count = 0
  end

  def add_energy(energy)
    @energy += energy
    @count += 1
  end

  def graph_keys
    {
      num_of_people: 'number',
      energy_average: 'number'
    }
  end

  def graph_values
    [@num_of_people, average]
  end

  def average
    @energy / @count.to_f / @num_of_people.to_f
  end
end
