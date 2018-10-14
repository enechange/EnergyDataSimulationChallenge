# RAILS_ENV=development bundle exec rake csv_loader:house
# RAILS_ENV=development bundle exec rake csv_loader:data_set
namespace :csv_loader do
  task :house => :environment do
    p "Start Import"
    HouseData.import('../../../data/house_data.csv')
    p "Finish Import"
  end
  task :data_set => :environment do
    p "Start Import"
    DataSetSample.import('../../../data/dataset_50.csv')
    p "Finish Import"
  end
end
