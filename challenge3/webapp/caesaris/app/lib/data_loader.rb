require 'csv'
require 'open-uri'

class DataLoader
  class << self
    def load_houses(uri)
      file = nil
      if uri !~ /^https?|^ftp\:\/\//
        file = File.open(uri, 'r')
      else
        file = open(uri)
      end
      labels = %w(Firstname Lastname num_of_people has_child)
      ActiveRecord::Base.transaction do
        CSV.new(file, :headers => :first_row).each do |line|
          house = House.new
          house.id = line['ID'] # TODO: deal with adding new files
          house.city_text = line['City'] # City for City class
          labels.each do |label|
            house[label.underscore.to_sym] = line[label]
          end
          house.save!
        end
      end
    end

    def load_cities
      city_texts = House.group(:city_text).select(:city_text).map(&:city_text)
      ActiveRecord::Base.transaction do
        city_texts.each do |city_text|
          city = City.where(name: city_text).first
          if city.blank?
            city = City.new(name: city_text)
            city.save!
          end
        end
      end
    end

    def sync_cities_houses
      
    end

  end
end
