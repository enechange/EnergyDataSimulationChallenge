class DashboardController < ApplicationController
  def index
  end
  def show
    personal = {'name': 'Yamada', 'old': 28}
    render json: personal
  end
end
