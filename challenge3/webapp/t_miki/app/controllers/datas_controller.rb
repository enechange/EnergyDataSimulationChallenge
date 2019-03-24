class DatasController < ApplicationController
  def index
    @city = House.group(:city).count
    @num_of_people = House.group(:num_of_people).count
  end
end
