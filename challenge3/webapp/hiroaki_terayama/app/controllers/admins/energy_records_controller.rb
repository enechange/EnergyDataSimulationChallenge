module Admins
  class EnergyRecordsController < ApplicationController

    def new
    end

    def create
      errors = EnergyRecord.import_csv(params[:csv_file].path)
      if !errors
        redirect_to new_energy_record_path, flash: { success: 'インポート成功！' }
      else
        render :new
      end
    end
  end
end
