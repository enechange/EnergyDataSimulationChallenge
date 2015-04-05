class Energy < ActiveRecord::Base
  belongs_to :house

  def self.as_csv
    eager_load :house
    mapping = {
      label: :label,
      year:  :year,
      month: -> (r) { "%02d" % r.month },
      temperature: :temperature,
      daylight: :daylight,
      energy_production: :energy_production,
      first_name: -> (r){ r.house.firstname },
      last_name: -> (r) { r.house.lastname },
      city: -> (r) { r.house.city },
      num_of_people: -> (r) { r.house.num_of_people },
      has_child: -> (r) { r.house.has_child },
    }
    CSV.generate do |csv|
      csv << mapping.keys
      all.each do |item|
        values = mapping.values.map do |callback|
          callback.to_proc.(item)
        end
        csv << values
      end
    end
  end
end
