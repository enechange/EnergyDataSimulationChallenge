module Admins
  class EnergyRecordsController < ApplicationController

    def new
    end

    def create
      if CsvHandler.import_csv(params[:csv_file].path, EnergyRecord)
        redirect_to new_admins_energy_record_path, flash: { success: 'インポート成功！' }
      else
        render :new
      end
    end
  end
end
