class ServiceController < ApplicationController
  protect_from_forgery
  def listhousedata
	@houses = Housedata.all
	render :json => @houses
  end

  def listdataset
	@dataset = Dataset.all
	render :json => @dataset
  end
end
