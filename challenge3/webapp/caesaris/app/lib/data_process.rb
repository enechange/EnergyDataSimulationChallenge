class DataProcess
  class << self
    # calc average energy_production per house for cities
    # res: { "Oxford" => { "2011-7" => [min, ave, max] } }
    def house_energy_prod_time_series
      results = {}
      City.all.each do |city|
        res_ttl = {}
        res_ave = {}
        city.houses.each do |house|
          house.datasets.order(:year, :month).each do |dataset|
            res_ttl[dataset.date_str] = [] if res_ttl[dataset.date_str].nil?
            res_ttl[dataset.date_str] << dataset.energy_production.to_f
          end
          res_ttl.each do |date_str, en_prods|
            res_ave[date_str] = [
              en_prods.min,
              en_prods.sum / en_prods.size.to_f,
              en_prods.max
            ]
          end
        end
        results[city.name] = res_ave
      end
      results
    end

    # calc average energy_production per person for cities
    def person_energy_prod_time_series
      results = {}
      City.all.each do |city|
        res_ttl = {}
        res_ave = {}
        city.houses.each do |house|
          house.datasets.order(:year, :month).each do |dataset|
            res_ttl[dataset.date_str] = [] if res_ttl[dataset.date_str].nil?
            res_ttl[dataset.date_str] << dataset.energy_production / house.num_of_people.to_f
          end
          res_ttl.each do |date_str, en_prods|
            res_ave[date_str] = [
              en_prods.min,
              en_prods.sum / en_prods.size.to_f,
              en_prods.max
            ]
          end
        end
        results[city.name] = res_ave
      end
      results
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


