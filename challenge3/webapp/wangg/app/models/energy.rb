class Energy < ActiveRecord::Base
	# associations
	belongs_to :house

	# data validations
	validates :year, :presence=>true,
					 :numericality=> true

	validates :month, :presence=>true,
					  :numericality=> true

	validates :temperature, :presence=>true,
					        :numericality=> true

	validates :daylight, :presence=>true,
					     :numericality=> true

	validates :energy_production, :presence=>true,
					 			  :numericality=> true
end
