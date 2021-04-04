# frozen_string_literal: true

require 'csv'

class Importer
  DATA_PATH = './data/'.freeze

  def import
    CSV.read(DATA_PATH + @path).map do |row|
      @plan.new(*row)
    end
  end
end
