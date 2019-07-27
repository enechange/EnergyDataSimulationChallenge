class HouseDatumController < ApplicationController
 def index
  @housedata = HouseDatum.all
 end
end