require 'rails/all'
require 'csv'

class CsvController < ApplicationController
  def import
    if params[:file] != nil then
      if params[:file].original_filename == "dataset_50.csv" then
        Dataset.import(params[:file])
      elsif params[:file].original_filename == "house_data.csv" then
        HouseDatum.import(params[:file])
      end
    end
  end

  def index
    @house_data = HouseDatum.all
    @dataset = Dataset.all

    # sqlでデータを集計
    # City別エネルギー生産量
    if @house_data.present? &&  @dataset.present? then
      sql = '
              SELECT
                city, count(*) as count
              FROM
                house_data
              GROUP BY
                city
            '
      city_house_count = ActiveRecord::Base.connection.select_all(sql).to_hash
      city_house_count.each do |data|
        @london_housese = data["count"] if data["city"] == "London"
        @cambrige_housese = data["count"] if data["city"] == "Cambridge"
        @oxford_housese = data["count"] if data["city"] == "Oxford"
      end

      sql = '
              SELECT
                city, SUM(energyproduction) as production
              FROM
                datasets
              INNER JOIN
                house_data
                ON datasets.house = house_data.id
              GROUP BY
                city
            '
      city_energy = ActiveRecord::Base.connection.select_all(sql).to_hash

      city_energy.each do |data|
        @London = data["production"] if data["city"] == 'London'
        @Cambridge = data["production"] if data["city"] == 'Cambridge'
        @Oxford = data["production"] if data["city"] == 'Oxford'
      end

      # エネルギー生産量
      sql = '
              SELECT
                year, month, SUM(energyproduction) as production, city
              FROM
                datasets
              INNER JOIN
                house_data
                ON datasets.house = house_data.id
              GROUP BY
                year, month, city
              ORDER BY
                year ASC, month ASC;
            '
      sql_result = ActiveRecord::Base.connection.select_all(sql).rows
      @lodon_year_energy = []
      @cambridge_year_energy = []
      @oxford_year_energy = []
      sql_result.each do |data|
        if data[3] == "London" then
          @lodon_year_energy.push [data[0], data[1], data[2]]
        elsif data[3] == "Cambridge" then
          @cambridge_year_energy.push [data[0], data[1], data[2]]
        elsif data[3] == "Oxford" then
          @oxford_year_energy.push [data[0], data[1], data[2]]
        end
      end
    end
  end
end
