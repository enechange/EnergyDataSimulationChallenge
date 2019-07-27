class DatasetController < ApplicationController
 def index
  @datasets = Dataset.all
  @count_energyproduction = Dataset.group(:EnergyProduction).count(:EnergyProduction)
 end
end