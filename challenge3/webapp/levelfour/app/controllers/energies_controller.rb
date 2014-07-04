class EnergiesController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def list
	  @data = Energy.find(:all)
  end

  def detail
  end
end
