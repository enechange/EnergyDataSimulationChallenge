class HousedataController < ApplicationController
  protect_from_forgery
  def show
	@houses = House.order(:house)
  end
end
