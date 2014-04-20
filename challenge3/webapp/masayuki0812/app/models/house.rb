class House < ActiveRecord::Base
  has_many :energies
  belongs_to :city

  def self.energies(id)
    house = find(id)

    # TODO: This range should be given
    # generate row keys explicitly to allow gap of data
    target_dates = []
    for y in [2011, 2012, 2013]
      for m in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        next if (y == 2011 and m < 7) or (y == 2013 and 6 < m)
        target_dates += ["%d-%02d" % [y, m]]
      end
    end

    # reconstruct guery result for easy result generation
    data_by_date = {}
    if house
      house.energies.each { |d|
        key = "%d-%02d" % [d.year, d.month]
        data_by_date[key] = [d.energy_production, d.daylight]
      }
    end

    # generate result rows
    rows = [['date', 'Energy Production', 'Daylight']]
    target_dates.each { |target_date|
      row = [target_date]
      if data_by_date.has_key?(target_date)
        row += data_by_date[target_date]
      elsif
        row += [0, 0]
      end
      rows += [row]
    }

    {
      data: rows
    }
  end

  def self.count_by_city_id(id=nil)
    count = House.select(:city_id).group('city_id').count()
    id ? count[id.to_i] : count
  end

end
