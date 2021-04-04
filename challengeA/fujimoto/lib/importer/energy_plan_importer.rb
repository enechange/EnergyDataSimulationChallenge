# frozen_string_literal: true

require_relative 'importer'

class EnergyPlanImporter < Importer
  def initialize(path)
    @path = path
    @plan = Struct.new(:id, :provider_id, :kwh_min, :price)
  end
end
