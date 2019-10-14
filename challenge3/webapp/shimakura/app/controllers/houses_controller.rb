class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy]

  # GET /houses
  # GET /houses.json
  def index
    @houses = House.all.page(params[:page]).per(15)
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
    @house = House.find(params[:id])
    @energy_list = []
    @temperature_list = []
    @daylight_list = []
    @energy_production_list = []
    @house.energies.each do |energy|
      date = energy.year.to_s + '年' + energy.month.to_s + '月'
      temperature = energy.temperature
      daylight = energy.daylight
      energy_production = energy.energy_production
      tmp = {
        "date" => date,
        "temperature" => temperature,
        "daylight" => daylight,
        "energy_production" => energy_production}
      @energy_list.push(tmp)
      @temperature_list.push([date, temperature])
      @daylight_list.push([date, daylight])
      @energy_production_list.push([date, energy_production])
    end
  end

  # GET /houses/new
  def new
    @house = House.new
  end

  # GET /houses/1/edit
  def edit
  end

  # POST /houses
  # POST /houses.json
  def create
    @house = House.new(house_params)

    respond_to do |format|
      if @house.save
        format.html { redirect_to @house, notice: 'House was successfully created.' }
        format.json { render :show, status: :created, location: @house }
      else
        format.html { render :new }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html { redirect_to houses_url, notice: 'House was successfully updated.' }
        format.json { render :show, status: :ok, location: @house }
      else
        format.html { render :edit }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house.destroy
    respond_to do |format|
      format.html { redirect_to houses_url, notice: 'House was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_params
      params.require(:house).permit(:firstname, :lastname, :city, :num_of_people, :has_child)
    end
end
