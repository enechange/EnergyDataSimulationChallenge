class HousesController < ApplicationController
  def index
    @houses = House.all
    @house_data = Energy.group(:house).sum(:energy_production)
  end
  
  def import
    # fileはtmpに自動で一時保存される
    House.import(params[:file])
    redirect_to action: 'index', notice: "データを追加しました。"
  end
end
