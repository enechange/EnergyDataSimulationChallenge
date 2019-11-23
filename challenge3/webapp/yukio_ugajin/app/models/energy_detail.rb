class EnergyDetail < ApplicationRecord
  # Association
  belongs_to :house

  # Validation
  validates :label,
            presence: true, numericality: { only_integer: true }
  validates :year,
            presence: true, numericality: { only_integer: true }
  validates :month,
            presence: true, numericality: { only_integer: true }
  validates :temperture,
            presence: true, numericality: true
  validates :daylight,
            presence: true, numericality: true
  validates :energy_production,
            presence: true, numericality: { only_integer: true }

  def self.all_data
    position_data = []
    EnergyDetail.all.each do |e|
      position_data << e.scatter_position
    end
    ['All Data', '#FFF5F5', '#d10000', position_data]
  end

  def self.city_data(city)
    position_data = []
    energies = EnergyDetail.joins(:house).where(houses: { city: city })

    energies.each do |e|
      position_data << e.scatter_position
    end

    if city == 'cambridge'
      ['cambridge', '#FFF5F5', '#d10000', position_data]
    elsif city == 'london'
      ['london', '#FFFDE5', '#ffbb00', position_data]
    elsif city == 'oxford'
      ['oxford', '#F5FCFF', '#0000F5', position_data]
    end
  end

  def self.num_of_people_data(num)
    position_data = []
    energies = EnergyDetail.joins(:house).where(houses: { num_of_people: num })

    energies.each do |e|
      position_data << e.scatter_position
    end

    if num == 2
      ['2', '#FFF5F5', '#d10000', position_data]
    elsif num == 3
      ['3', '#FFFDE5', '#ffbb00', position_data]
    elsif num == 4
      ['4', '#F5FCFF', '#0000F5', position_data]
    elsif num == 5
      ['5', '#E5FFED', '#00C217', position_data]
    elsif num == 6
      ['6', '#FCE5FF', '#A800C2', position_data]
    end
  end

  def self.has_child_data(answer)
    position_data = []
    energies = EnergyDetail.joins(:house).where(houses: { has_child: answer })

    energies.each do |e|
      position_data << e.scatter_position
    end

    if answer
      ['YES', '#FFF5F5', '#d10000', position_data]
    else
      ['NO', '#F5FCFF', '#0000F5', position_data]
    end
  end

  def scatter_position
    { x: daylight, y: energy_production }
  end
end
