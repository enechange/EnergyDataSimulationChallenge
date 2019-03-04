require 'csv'
class CsvHandler

  def self.import_csv(path, model)
    begin
      data_array = []
      CSV.foreach(path, headers: true) do |row|
        data = model.find_by(origin_id: row['ID'].to_i)
        if data
          data.attributes = model.get_attributes(row)
          data.save!
        else
          data_array << model.get_attributes(row)
        end
      end
      model.import(data_array)
      true
    end
  rescue => e
    p e
    false
  end
end