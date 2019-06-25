class House < ApplicationRecord
  belongs_to :city
  belongs_to :family
end
