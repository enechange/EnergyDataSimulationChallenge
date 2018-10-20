require 'csv'
class HouseData < ApplicationRecord
  enum has_child: { No: 0, Yes: 1 }
  validates :id, presence: true, numericality: { only_integer: true }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :city, presence: true
  validates :num_of_people, presence: true, numericality: { only_integer: true }
  validates :has_child, presence: true

  def self.get_average_tempreture
    HouseData.group(:city).sum(:num_of_people)
  end

  def self.import(file)
    begin
      CSV.foreach(file, headers: true) do |row|
        house_data = self.find_by(id: row['ID'].to_i) || self.new
        house_data.attributes = {
          id: row['ID'].to_i,
          first_name: row['Firstname'],
          last_name: row['Lastname'],
          city: row['City'],
          num_of_people: row['num_of_people'].to_i,
          has_child: row['has_child'].downcase.eql?('yes') ? 1 : 0
        }
        house_data.save!
      end
    rescue => e
      p e.inspect
      p e.message
      p 'Error has occoured, check the format of csv'
    end
  end

end
