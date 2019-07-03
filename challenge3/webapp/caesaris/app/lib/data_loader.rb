require 'csv'
require 'open-uri'

class DataLoader
  class << self
    ### For Challenge 3 ###
    def load_houses(uri)
      file = load_file_as_stream(uri)
      ActiveRecord::Base.transaction do
        CSV.new(file, **csv_options).each do |line|
          # CSV headers:
          # :id, :firstname, :lastname, :city, :num_of_people, :has_child
          house_params = line.to_hash
          House.create!(
            **house_params.except(:id, :city),
            city_text: house_params[:city],
            # House ID is used by Datasets, must use csv's ID
            id: house_params[:id], # TODO: deal with IDs when adding new files
          )
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
      cities = City.all
      ActiveRecord::Base.transaction do
        cities.each do |city|
          houses = House.where(city_text: city.name)
          houses.update_all(city_id: city.id)
        end
      end
    end

    def load_dataset(uri)
      file = load_file_as_stream(uri)
      ActiveRecord::Base.transaction do
        CSV.new(file, **csv_options).each do |line|
          # CSV headers:
          # :id, :label, :house, :year, :month, :temperature, :daylight, :energy_production
          dataset_params = line.to_hash
          Dataset.create!(
            **dataset_params.except(:id, :house),
            house_id: dataset_params[:house],
            id: dataset_params[:id], # TODO: deal with IDs when adding new files
          )
        end
      end
    end

    def load_file_as_stream(uri)
      file = nil
      if uri !~ /^https?|^ftp\:\/\//
        file = File.open(uri, 'r')
      else
        file = open(uri)
      end
      file
    end

    def csv_options
      {
        headers: :first_row,
        header_converters: lambda { |h| h.underscore.to_sym },
        converters: :all,
        skip_blanks: true,
      }
    end

  end
end
