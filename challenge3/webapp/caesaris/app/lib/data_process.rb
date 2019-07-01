class DataProcess
  class << self
    # calc average energy_production per house for cities
    def house_energy_prod_time_series
      DataProcess.cities_datasets_time_series(:energy_production)
    end

    # calc average energy_production per person for cities
    def person_energy_prod_time_series
      max = Arel.sql('MAX(per_person)').as('max')
      min = Arel.sql('MIN(per_person)').as('min')
      avg = Arel.sql('AVG(per_person)').as('avg')

      City.all.each_with_object({}) do |city, results|
        sql = <<-SQL
          (SELECT year, month,
            (CAST(energy_production AS FLOAT) / CAST(num_of_people AS FLOAT)) AS per_person
          FROM datasets, houses
          WHERE "datasets"."house_id" = "houses"."id" AND "houses"."city_id" = #{city.id})
        SQL

        arel = Arel::Table.new(nil).project(:year, :month, max, min, avg)
          .from(Arel.sql(sql).as('datasets_per_person'))
          .group(:year, :month).order(:year, :month)
        con = ActiveRecord::Base.connection
        results[city.name] = con.select_all(arel)
          .to_hash.each_with_object({}) do |sql_res, eng_prod_list|
            date_str = DataProcess.date_str(sql_res['year'], sql_res['month'])
            eng_prod_list[date_str] = [
              sql_res['min'],
              sql_res['avg'],
              sql_res['max'],
            ]
          end
      end
    end

    # key: [:daylight, :temperature]
    def weather_time_series(key)
      DataProcess.cities_datasets_time_series(key)
    end

    # key: [:daylight, :temperature, :energy_production]
    # res: { "Oxford" => { "2011-07" => [min, avg, max] } }
    def cities_datasets_time_series(key)
      data_selector = Dataset.arel_table[key]
      max = data_selector.maximum.as('max')
      min = data_selector.minimum.as('min')
      avg = data_selector.average.as('avg')

      City.all.each_with_object({}) do |city, results|
        results[city.name] = city.datasets
          .select(:year, :month, max, min, avg)
          .group(:year, :month).order(:year, :month)
          .each_with_object({}) do |sql_res, dataset_list|
            date_str = DataProcess.date_str(sql_res.year, sql_res.month)
            dataset_list[date_str] = [
              sql_res.min.to_f,
              sql_res.avg.to_f,
              sql_res.max.to_f,
            ]
          end
      end
    end

    def date_str(year, month)
      "#{year}-#{month.to_s.rjust(2, '0')}"
    end
  end
end
