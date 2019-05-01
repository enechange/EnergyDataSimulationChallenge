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
  def self.id(label)
    CITIES[label.to_sym]
  end

  def self.label(id)
    CITIES.key(id).to_s
  end

  def self.all
    CITIES
  end
end
