require_relative "importer"

class BasicPlanImporter < Importer

  def initialize(path)
    @path = path
    @plan = Struct.new(:id, :provider_id, :amps, :price)
  end

end