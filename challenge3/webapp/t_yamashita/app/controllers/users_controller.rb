class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :access_limit, only: [:comparison, :self_sufficiency]

  def show
  end

  def menu
  end

  def comparison
    # @chart_data = [[横軸, 縦軸], [横軸, 縦軸], ・・・・・・, [横軸, 縦軸]]
    # @chart_data = { 横軸: 縦軸, 横軸: 縦軸, ・・・・・・, 横軸: 縦軸 }
    # @chart_data = Model.order('data ASC').group(:date).count
    @energies = Energy.where(user_id: current_user.id).order(:month, :year)

    if @energies.present?
      array = []
      @energies.each do |e|
        arr = ["#{e.year}.#{e.month}", e.energy_production]
        array << arr
      end

      @chart_data = array
    end

  end

  def self_sufficiency
    my_energy = Energy.where(user_id: current_user.id)

    if my_energy.present?
      # 発電量の記録基準で最新レコードがあれば年・月を取得
      @recently_year = Energy.recently_year(current_user.id)
      @recently_month = Energy.recently_month(current_user.id)

      # 発電量の最新レコードを取得し、それと同じ年・月に対応する消費量のレコードを取得
      energy = Energy.find_by(user_id: current_user.id, year: @recently_year, month: @recently_month)
      power = PowerConsumption.find_by(user_id: current_user.id, year: @recently_year, month: @recently_month)
    end

    # 発電量と消費電力の合計値をそれぞれ算出
    energy_total = Energy.total_energy(current_user.id)
    power_total = PowerConsumption.total_power(current_user.id)

    # powerとenergyが両方とも存在しなければ自給率が表現できない
    if power && energy 
      @chart_data = [[ "消費電力", power.power_consumption ],[ "発電量", energy.energy_production ]]

      self_sufficiency_rate = energy.energy_production/power.power_consumption.to_f*100
      @rate = self_sufficiency_rate.round(0)

      @chart_total_data = [["消費電力", power_total], ["発電量", energy_total]]

      total_self_sufficiency_rate = energy_total/power_total.to_f*100
      @total_rate = total_self_sufficiency_rate.round(0)
    end
  end

  private

  def access_limit
    user = User.find(params[:id])
    if user.id != current_user.id
      redirect_to new_user_session_path
    end
  end
end
