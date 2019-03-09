class HousesController < ApplicationController
  def index
    @houses = House.all.includes(:energies)
  end

  def show
    @house = House.find(params[:id])
  end

  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    if @house.save
      flash[:success] = "データの追加に成功しました"
      redirect_to root_url
    else
      flash[:danger] = "データの追加に失敗しました"
      render new_house_path
    end
  end

  def edit
    @house = House.find(params[:id])
  end

  def update
    @house = House.find(params[:id])
    if @house.update_attributes(house_params)
      flash[:success] = "データの更新に成功しました"
      redirect_to root_url
    else
      flash[:danger] = "データの更新に失敗しました"
      render edit_house_path
    end
  end

  def destroy
  end

  private

  def house_params
    params.require(:house).permit(:firstname, :lastname, :city, :num_of_people, :has_child)
  end
end
