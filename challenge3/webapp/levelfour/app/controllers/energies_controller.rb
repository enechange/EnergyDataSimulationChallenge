class EnergiesController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def list
	  @data = Energy.page params[:page]
  end

  def detail
  end
end
