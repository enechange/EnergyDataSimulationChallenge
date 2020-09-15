class Energy < ApplicationRecord
  require 'time'
  attr_accessor :gotten_at
  after_find :set_gotten_at
  belongs_to :house

  def set_gotten_at
    self.gotten_at = Time.local(self.year, self.month)
  end
end
