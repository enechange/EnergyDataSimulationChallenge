class ProvidersController < ApplicationController
  def new
    @provider = Provider.new
  end

  def create
    if Provider.create(provider_params)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def provider_params
    params.require(:provider).permit(:name)
  end

end
