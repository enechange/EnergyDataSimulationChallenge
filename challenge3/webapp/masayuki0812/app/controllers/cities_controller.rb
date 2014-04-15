class CitiesController < ApplicationController
  before_action :set_city, only: [:edit, :update, :destroy]

  # GET /cities
  # GET /cities.json
  def index
    @cities = City.all(with_count_house=true, with_total_energy_production=true)
  end

  # GET /cities/1(/target)
  # GET /cities/1(/target).json
  def show
    if params[:target] == 'energies'
      @energies = City.energies(params[:id])
      render :action => 'show_energies'
    elsif params[:id] == 'energies'
      @energies = City.energies()
      render :action => 'show_energies'
    else
      @city = City.find(params[:id], with_count_house=true, with_total_energy_production=true)
    end
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
#        format.html { redirect_to @city, notice: 'City was successfully created.' }
        format.json { render action: 'show', status: :created, location: @city }
      else
#        format.html { render action: 'new' }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
#        format.html { redirect_to @city, notice: 'City was successfully updated.' }
        format.json { head :no_content }
      else
#        format.html { render action: 'edit' }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
    respond_to do |format|
#      format.html { redirect_to cities_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name)
    end
end
