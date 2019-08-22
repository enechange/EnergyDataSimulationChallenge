class Energy < ApplicationRecord

  belongs_to :house

  validates :label, :house_id, :year, :month, :temperature, :daylight, :energy_production, presence: true
  validates :house_id, uniqueness: { scope: %i(year month) }

  class << self
    def csv_header_converters
      lambda do |name|
        {
            ID:               :id,
            Label:            :label,
            House:            :house_id,
            Year:             :year,
            Month:            :month,
            Temperature:      :temperature,
            Daylight:         :daylight,
            EnergyProduction: :energy_production
        }[name.intern] || raise
      end
    end

    def csv_converters
    end

    def sum_graph_data(year:, month:)
      _year = year.present? ? year : 2013 #Time.current.year
      _month = month.present? ? month : 6 #Time.current.month
      result = Energy.where(year: _year, month: _month).joins(:house).group('houses.city').sum(:energy_production)
      {year: _year, month: _month}.merge(report: result)
    end

    def avg_graph_data(city: House::CITIES.first, num_of_people:, has_child:)
      houses = House.where(city: city).tap do |houses|
        houses.where!(num_of_people: num_of_people) if num_of_people.present?
        houses.where!(has_child: has_child) if has_child.present?
      end

      Energy.select(<<-SQL).
        year, month,
        ROUND(AVG(temperature), 1) AS temperature_avg,
        ROUND(AVG(daylight), 1) AS daylight_avg,
        ROUND(AVG(energy_production)) AS energy_production_avg
      SQL
      where(house_id: houses.pluck(:id)).group(:year, :month).inject({}) do |h, r|
        h[:dates] = (h[:dates] || []).push("#{r.year}/#{r.month}")
        h[:temperature_avg] = (h[:temperature_avg] || []).push(r.temperature_avg.to_f)
        h[:daylight_avg] = (h[:daylight_avg] || []).push(r.daylight_avg.to_f)
        h[:energy_production_avg] = (h[:energy_production_avg] || []).push(r.energy_production_avg)
        h
      end
    end

  end

end
