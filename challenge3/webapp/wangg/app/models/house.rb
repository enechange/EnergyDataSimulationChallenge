class House < ActiveRecord::Base
	# associations
	has_many :energies

	# data validation
	validates :first_name, :presence=> true,
						   :numericality=> false

	validates :last_name, :presence=> true,
						  :numericality=> false

	validates :city, :presence=> true,
					 :numericality=> false

	validates :num_of_people, :presence=> true,
						   :numericality=> true

	validates :has_child, :inclusion => {:in => [true, false]}

end
