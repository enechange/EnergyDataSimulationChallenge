class StaticPagesController < ApplicationController
  def top; end

  def all
    @all_house = House.all
  end

end