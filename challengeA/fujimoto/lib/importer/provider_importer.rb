require_relative "importer"

class ProviderImporter < Importer

  def initialize(path)
    @path = path
    @plan = Struct.new(:id, :name, :plan_name)
  end

end