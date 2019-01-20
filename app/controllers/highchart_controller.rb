require "ostruct"

class HighchartController < ApplicationController
  def index
    form = Highchart::IndexForm.new(params)
    service = Highchart::IndexService.new(form)

    @data_sets = service.execute
  end
end
