namespace :csv_import do
  desc 'house_data.csv'
  task houses: :environment do
    make_house_data
  end

  desc 'dataset_50.csv'
  task energies: :environment do
    make_energy_data
  end
end


def make_house_data
  # do house data
  puts "make house data"
end

def make_energy_data
  # do energy data
  puts "make energy data"
end