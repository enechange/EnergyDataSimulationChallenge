class EnergiesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:add]

  def index
  end

  def new
  end

  def add
    data = Energy.new

    data.house_id = params[:house_id]
    data.label = Energy.where(:house_id => params[:house_id]).pluck(:label).max + 1
    data.month = Date.new(params[:year].to_i, params[:month].to_i)
    data.temperature = params[:temperature]
    data.daylight = params[:daylight]
    data.energy_production = params[:energy_production]
    data.save

    flash[:success] = "house data updated successfully"
    redirect_to :controller => "houses",
      :action => "detail", :id => params[:house_id]
  end

  def edit
  end

  def list
	  @data = Energy.page params[:page]
  end

  def detail
  end
end
