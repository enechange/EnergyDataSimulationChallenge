require_relative "importer"

class LabelImporter < Importer

  def initialize(path)
    @path = path
    @plan = Struct.new(:id, :company_name, :plan_name)
  end

end