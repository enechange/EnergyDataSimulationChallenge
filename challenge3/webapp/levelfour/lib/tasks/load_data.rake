namespace :data do
	require 'csv'

	desc "!! execute in the root of rails project !!"
	task :import => :environment do
		CSV.foreach("../../data/house_data_nocolumnname.csv", "r") do |row|
			begin
				house = House.find(row[0].to_i)
			rescue ActiveRecord::RecordNotFound
				house = House.new
			end
			house.id = row[0].to_i
			house.first_name = row[1]
			house.last_name = row[2]
			house.city = row[3]
			house.num_of_people = row[4].to_i
			house.has_child = (row[5] == "Yes") ? 1 : 0
			house.save
		end

		CSV.foreach("../../data/dataset_50_nocolumnname.csv", "r") do |row|
			begin
				data = Energy.find(row[0].to_i)
			rescue ActiveRecord::RecordNotFound
				data = Energy.new
			end
			data.id = row[0].to_i
			data.house_id = row[2].to_i
			data.label = row[1].to_i
			data.month = Date.new(row[3].to_i, row[4].to_i)
			data.temperature = row[5].to_f
			data.daylight = row[6].to_f
			data.energy_production = row[7].to_i
			data.save
		end
	end
end
