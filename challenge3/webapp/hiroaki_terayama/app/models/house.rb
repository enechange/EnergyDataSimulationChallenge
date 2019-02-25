require 'csv'
class House < ApplicationRecord
  enum has_child: { Yes: true, No: false }

  has_many :energy_records

  validates :origin_id, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :city, presence: true
  validates :num_of_people, presence: true, numericality: { only_integer: true }
  validates :has_child, presence: true

  def self.import_csv(path)
    begin
      data_array = []
      CSV.foreach(path, headers: true) do |row|
        data = House.find_by(origin_id: row['ID'].to_i) || new
        if data.id
          set_attributes(data, row)
          data.save!
        else
          data_array << set_attributes(data, row)
        end
      end
      self.import(data_array)
    end
  rescue => e
    p e
    e
  end

  private
    def self.set_attributes(data, row)
      data.attributes = {
          origin_id: row['ID'].to_i,
          firstname: row['Firstname'],
          lastname: row['Lastname'],
          city: row['City'],
          num_of_people: row['num_of_people'].to_i,
          has_child: row['has_child']
      }
    end
end
