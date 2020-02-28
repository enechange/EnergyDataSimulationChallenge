class House < ApplicationRecord
  has_many :data
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :city, presence: true
  validates :num_of_people, presence: true
  validates :has_child, inclusion: { in: [true, false] }

  def self.import(file)
    CSV.foreach(file, headers: true) do |row|
      house = new(
        csv_id:         row["ID"],
        firstname:      row["Firstname"],
        lastname:       row["Lastname"],
        city:           row["City"],
        num_of_people:  row["num_of_people"],
        has_child:      row["has_child"],
      )
      house.save!
    end
  end

  def fullname
    "#{self.firstname} #{self.lastname}"
  end

  def monthly_sort
    output = []
    energyProduction_perMonth = []
    daylight_perMonth = []
    temperature_perMonth = []
    self.data.each do |d|
      energyProduction_perMonth << [d.month_of_year, d.energy_production]
      daylight_perMonth << [d.month_of_year, d.daylight]
      temperature_perMonth << [d.month_of_year, d.temperature.to_f]
    end
    output = [
      {name: "日照エネルギー", data: daylight_perMonth},
      {name: "エネルギー産出量", data: energyProduction_perMonth},
      {name: "気温", data: temperature_perMonth}
    ]    
  end


end
