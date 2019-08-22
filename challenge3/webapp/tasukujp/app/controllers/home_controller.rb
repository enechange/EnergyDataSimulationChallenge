class HomeController < ApplicationController

  def index
  end

  concerning :JsonApi do
    def sum_graph_data
      @result = Energy.sum_graph_data(
          year: params[:year], month: params[:month]
      )
      render json: @result
    end

    def avg_graph_data
      @result = Energy.avg_graph_data(
          city: params[:city],
          num_of_people: params[:num_of_people],
          has_child: params[:has_child]
      )
      render json: @result
    end
  end

end
