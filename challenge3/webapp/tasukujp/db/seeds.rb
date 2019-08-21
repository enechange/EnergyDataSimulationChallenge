require 'csv'

ActiveRecord::Base.transaction do

  import = ->(klass, filepath) do
    per = 100
    values = []
    options = {
        headers: :first_row,
        header_converters: klass.csv_header_converters,
        converters: klass.csv_converters
    }

    CSV.foreach(filepath, options) do |row|
      values.push(klass.new(row.to_h))
      if (values.size % per).zero?
        klass.import!(values, ignore: true)
        values.clear
      end
    end
    klass.import!(values, ignore: true) if values.present?
  end

  import.(House, Rails.root.join('db/data/house_data.csv'))
  import.(Energy, Rails.root.join('db/data/dataset_50.csv'))

end
