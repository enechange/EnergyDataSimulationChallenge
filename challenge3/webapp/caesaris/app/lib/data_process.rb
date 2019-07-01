class DataProcess
  class << self
    # calc average energy_production per house for cities
    # res: { "Oxford" => { "2011-07" => [min, avg, max] } }
    def house_energy_prod_time_series
      en_prods = Dataset.arel_table[:energy_production]
      max = en_prods.maximum.as('max')
      min = en_prods.minimum.as('min')
      avg = en_prods.average.as('avg')

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
      results = {}
      City.all.each do |city|
        res_ttl = {}
        res_ave = {}
        city.datasets.order(:year, :month).each do |dataset|
          res_ttl[dataset.date_str] = [] if res_ttl[dataset.date_str].nil?
          res_ttl[dataset.date_str] << dataset[key].to_f
        end
        res_ttl.each do |date_str, weather_infos|
          res_ave[date_str] = [
            weather_infos.min,
            weather_infos.sum / weather_infos.size.to_f,
            weather_infos.max
          ]
        end
        results[city.name] = res_ave
      end
      results
    end

    def date_str(year, month)
      "#{year}-#{month.to_s.rjust(2, '0')}"
    end
  end
end


