class House < ApplicationRecord
  has_many :data
  validates :csv_id, presence: true, numericality: { only_integer: true }
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :city, presence: true
  validates :num_of_people, presence: true, numericality: { only_integer: true }
  validates :has_child, inclusion: { in: [true, false], :message => "value should be only true or false"}

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

end
