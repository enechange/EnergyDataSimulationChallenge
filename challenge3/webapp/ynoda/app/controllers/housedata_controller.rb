class HousedataController < ApplicationController
  protect_from_forgery
  def show
	@houses = Housedata.order(:house)
  end
end
