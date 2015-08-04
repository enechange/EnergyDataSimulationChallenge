class ChargesController < ApplicationController

  protect_from_forgery with: :null_session

  def index
    respond_to do |format|
      format.html
      format.json {
        service = EnergyChargeService.new(request)
        @charge_response = service.serve!
      }
    end
  end

end
