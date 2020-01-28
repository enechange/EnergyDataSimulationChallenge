class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  module ArrayStatistics
    refine Array do
      def average
        sum.fdiv(size)
      end
    end
  end
end
