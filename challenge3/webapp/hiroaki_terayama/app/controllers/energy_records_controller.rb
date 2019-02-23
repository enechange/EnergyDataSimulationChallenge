class EnergyRecordsController < ApplicationController

  def new
  end

  def create
    EnergyRecord.import_csv(params[:csv_file].path)
    redirect_to new_energy_record_path, flash: { success: 'インポート完了！' }
  end
end
