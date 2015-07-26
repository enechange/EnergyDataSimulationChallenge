class ChargesController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json {
        @energy_charges = mock_response
      }
    end
  end

  private

  def mock_response
    [
      OpenStruct.new(plan_name: "A", price: 3210),
      OpenStruct.new(plan_name: "B", price: 2345),
    ]
  end
end
