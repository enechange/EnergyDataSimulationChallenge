class HousesController < ApplicationController
  def index
    @houses       = House.all
    @house_data   = @houses.includes(:energies).take_energy_average
    @house_amount = @houses.includes(:energies).take_house_amount
    @data_term    = Energy.all.pluck(:year).uniq.sort
    @data_city    = @houses.pluck(:city).uniq.sort

    gon.data_city    = @data_city
    gon.data_term    = @data_term
    gon.house_data   = @data_city.map { |city| @house_data[city].values }
    gon.house_amount = @data_city.map { |city| @house_amount[city].values }
  end

  def show
    @house = House.find(params[:id])
    @house_eneriges = @house.energies.order('label')

    gon.data_month       = @house_eneriges.pluck(:month)
    gon.data_energyprod  = @house_eneriges.pluck(:energy_production)
    gon.data_temperature = @house_eneriges.pluck(:temperature)
    gon.data_daylight    = @house_eneriges.pluck(:daylight)

  end

  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    if @house.save
      flash[:success] = "#{@house.firstname} #{@house.lastname}のデータを追加しました"
      redirect_to houses_url
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
    @house = House.find(params[:id])
    @house.destroy
    flash[:success] = "#{@house.firstname} #{@house.lastname}のデータを削除しました"
    redirect_to houses_url
  end

  private

    def house_params
      params.require(:house).permit(:firstname, :lastname, :city, :num_of_people, :has_child)
    end
end
