# RAILS_ENV=development bundle exec rake csv_loader:house
# RAILS_ENV=development bundle exec rake "csv_loader:data_set[geographic_sections]"
namespace :csv_loader do
  task :house => :environment do
    p "Start Import"
    HouseData.import('../../../data/house_data.csv')
    p "Finish Import"
  end
  task :data_set => :environment do
    p "Hello2"
    DataSetSample.import('../../../data/dataset_50.csv')
  end
end
