class HousesController < ApplicationController

  def new
  end

  def create
    House.import_csv(params[:csv_file].path)
    redirect_to new_house_path, flash: { success: 'インポート完了！' }
  end
end
