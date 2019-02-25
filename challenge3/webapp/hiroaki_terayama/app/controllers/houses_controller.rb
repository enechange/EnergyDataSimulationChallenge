class HousesController < ApplicationController

  def new
  end

  def create
    errors = House.import_csv(params[:csv_file].path)
    if !errors
      redirect_to new_house_path, flash: { success: 'インポート成功！' }
    else
      render :new, @message
    end
  end
end
