namespace :wangg do
  desc "TODO"
  task csv: :environment do
  	require 'csv'    
  	
  	csv_text = File.read('house_data_nocolumnname.csv')
  	csv = CSV.parse(csv_text, :headers => false)
  	csv.each do |row|
	  	house=House.new
	  	house.first_name=row[1]
	  	house.last_name=row[2]
	  	house.city=row[3]
	  	house.num_of_people=row[4]
	  	if row[5]=="Yes"
	  		house.has_child=true
	  	else
	  		house.has_child=false
	    end
	    house.save
  	end

	csv_text = File.read('dataset_50_nocolumnname.csv')
  	csv = CSV.parse(csv_text, :headers => false)
  	csv.each do |row|
  		energy=Energy.new
  		energy.label=row[1]
  		energy.house_id=row[2]
  		energy.year=row[3]
  		energy.month=row[4]
  		energy.temperature=row[5]
  		energy.daylight=row[6]
  		energy.energy_production=row[7]
  		energy.save
  	end

  end

  task add_account: :environment do
    admin_user=AdminUser.new
    admin_user.username="admin"
    admin_user.password="admin"
    admin_user.save
  end
end
