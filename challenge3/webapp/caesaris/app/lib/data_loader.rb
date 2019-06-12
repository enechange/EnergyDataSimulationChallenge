require 'csv'
require 'open-uri'

class DataLoader
  class << self
    def load_houses(uri)
      file = nil
      if uri !~ /^https?|^ftp\:\/\//
        file = File.open(uri, 'r')
      else
        file = open(uri)
      end
      CSV.new(file, :headers => :first_row).each do |line|
        p line
      end
    end
  end
end
