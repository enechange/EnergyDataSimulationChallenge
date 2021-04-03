require_relative "importer"

class EnergyPlanImporter < Importer

  def initialize(path)
    @path = path
    @plan = Struct.new(:id, :plan_id, :kwh_min, :price)
  end

end