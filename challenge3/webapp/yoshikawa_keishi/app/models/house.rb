class House < ApplicationRecord
  has_many :data, dependent: :destroy
  validates :csv_id, presence: true, numericality: { only_integer: true }
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :city, presence: true
  validates :num_of_people, presence: true, numericality: { only_integer: true }
  validates :has_child, inclusion: { in: ["Yes", "yes", "No", "no"], :message => "value should be only Yes(yes) or No(no)"}
  

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
    "#{firstname} #{lastname}"
  end

  # def monthly_data
  #   output = []
  #   energyProduction_perMonth = []
  #   daylight_perMonth = []
  #   temperature_perMonth = []
  #   data.each do |d|
  #     month_of_year = d.month_of_year
  #     energyProduction_perMonth << [month_of_year, d.energy_production]
  #     daylight_perMonth << [month_of_year, d.daylight]
  #     temperature_perMonth << [month_of_year, d.temperature.to_f]
  #   end
  #   output = [
  #     {name: "日照エネルギー", data: daylight_perMonth},
  #     {name: "エネルギー産出量", data: energyProduction_perMonth},
  #     {name: "気温", data: temperature_perMonth}
  #   ]    
  # end

  def fullname
    "#{firstname} #{lastname}"
  end

  def monthly_energyProduction
    data.map{|d| [d.month_of_year, d.energy_production]}
  end

  def monthly_daylight
    data.map{|d| [d.month_of_year, d.daylight]}
  end

  def monthly_temperature
    data.map{|d| [d.month_of_year, d.temperature.to_f]}
  end

  def monthly_data
    [
      {name: "日照エネルギー", data: monthly_daylight},
      {name: "エネルギー産出量", data: monthly_energyProduction},
      {name: "気温", data: monthly_temperature}
    ]    
  end


end
