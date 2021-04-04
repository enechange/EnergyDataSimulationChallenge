# frozen_string_literal: true

require 'smarter_csv'

class Importer
  DATA_PATH = './data/'

  def initialize(path)
    @path = path
  end

  def import
    SmarterCSV.process(DATA_PATH + @path)
  end
end
