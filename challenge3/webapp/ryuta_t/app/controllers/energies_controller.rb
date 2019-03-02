class EnergiesController < ApplicationController

  def index
    @energies = Energy.all
  end

  def show
    @energy = Energy.find(params[:id])
  end

  def new
    @energy = Energy.new
  end

  def create
    @energy = Energy.new(energy_params)
    if @energy.save
      flash[:success] = "データが追加されました"
      redirect_to root_url
    else
      flash[:danger] = "データの追加に失敗しました"
      render new_energy_path
    end
  end

  def edit
    @energy = Energy.find(params[:id])
  end

  def update
    @energy = Energy.find(params[:id])
    if @energy.update_attributes(energy_params)
      flash[:success] = "データの更新に成功しました"
      redirect_to root_url
    else
      flash[:danger] = "データの更新に失敗しました"
      render edit_energy_ath
    end
  end

  def destroy

  end

  private

    def energy_params
      params.require(:energy).permit(:label, :house_id, :year, :month, :temperature, :daylight, :energy_production)
    end
end
