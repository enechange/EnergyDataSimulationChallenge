class DatasetController < ApplicationController
 def index
  @datasets = Dataset.all
 end
end
