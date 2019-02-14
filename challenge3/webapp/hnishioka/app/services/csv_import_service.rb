class CsvImportService
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/mysql2_adapter'

  def self.call(model, path)
    new(model, path).import
  end

  def initialize(model, path)
    @model = model
    @path = path
  end

  def import
    instance_models = []
    CSV.foreach(
      @path,
      headers: true,
      header_converters: ->(h) { h.underscore.downcase.to_sym }
    ) do |row|
      instance_models << @model.new(row.to_h)
    end
    @model.import instance_models, raise_error: true
  end
end
