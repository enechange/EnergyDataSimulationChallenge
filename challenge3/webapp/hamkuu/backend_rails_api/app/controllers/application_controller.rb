class ApplicationController < ActionController::API
  def initialize
    # default page size for all resources
    @page_size = 20
  end

  protected

  def api_params
    params.permit(:id, :page)
  end
end
