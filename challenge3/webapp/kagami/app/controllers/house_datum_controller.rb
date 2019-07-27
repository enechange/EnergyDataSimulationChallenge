class HouseDatumController < ApplicationController
 def index
  @housedata = HouseDatum.all
  @count_child = HouseDatum.group(:has_child).count(:has_child)
 end
end