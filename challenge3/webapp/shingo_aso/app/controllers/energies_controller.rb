class EnergiesController < ApplicationController
  def index
    @energies = Energy.all
  end
  
  def import
    # fileはtmpに自動で一時保存される
    Energy.import(params[:file])
    redirect_to root_url, notice: "データを追加しました。"
  end
end
