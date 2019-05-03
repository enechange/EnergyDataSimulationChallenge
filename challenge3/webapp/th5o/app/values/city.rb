# 都市
class City

  CITIES = {
    Cambridge: 1,
    London: 2,
    Oxford: 3
  }

  module Attribute
    def self.included(klass)
      klass.class_eval do
        enum city: CITIES
      end
    end
  end

  #
  # Class Methods
  #
  def self.id(name)
    CITIES[name.to_sym]
  end

  def self.name(id)
    CITIES.key(id).to_s
  end

  def self.names
    CITIES.keys.map {|sym| sym.to_s }
  end

  def self.all
    CITIES
  end
end
