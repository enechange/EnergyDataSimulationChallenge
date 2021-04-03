require_relative "importer"

class BasicPlanImporter < Importer

  def initialize(path)
    @path = path
    @plan = Struct.new(:id, :plan_id, :amps, :price)
  end

end