require 'csv'

ActiveRecord::Base.transaction do

  import = ->(klass, filepath) do
    options = {
      encoding:          "UTF-8",
      headers:           true,
      header_converters: klass.csv_header_converters,
      converters:        klass.csv_converters
    }

    CSV.read(filepath, options).each_slice(1000) do |rows|
      values = rows.map(&:to_h).map { |row| klass.new(row) }
      klass.import! values, validate: true
    end
  end

  import.(Energy, Rails.root.join('db', 'data', 'dataset_50.csv'))
  import.(House, Rails.root.join('db', 'data', 'house_data.csv'))

end