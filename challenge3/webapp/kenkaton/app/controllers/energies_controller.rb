class EnergiesController < ApplicationController
  before_action :set_energy, only: [:show, :edit, :update, :destroy]

  # GET /energies
  # GET /energies.json
  def index
    @energies = Energy.all
  end

  # GET /energies/1
  # GET /energies/1.json
  def show
  end

  # GET /energies/new
  def new
    @energy = Energy.new
  end

  # GET /energies/1/edit
  def edit
  end

  # POST /energies
  # POST /energies.json
  def create
    @energy = Energy.new(energy_params)

    respond_to do |format|
      if @energy.save
        format.html { redirect_to @energy, notice: 'Energy was successfully created.' }
        format.json { render :show, status: :created, location: @energy }
      else
        format.html { render :new }
        format.json { render json: @energy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /energies/1
  # PATCH/PUT /energies/1.json
  def update
    respond_to do |format|
      if @energy.update(energy_params)
        format.html { redirect_to @energy, notice: 'Energy was successfully updated.' }
        format.json { render :show, status: :ok, location: @energy }
      else
        format.html { render :edit }
        format.json { render json: @energy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /energies/1
  # DELETE /energies/1.json
  def destroy
    @energy.destroy
    respond_to do |format|
      format.html { redirect_to energies_url, notice: 'Energy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_energy
      @energy = Energy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def energy_params
      params.require(:energy).permit(:label, :house_id, :year, :month, :temperature, :daylight, :energy_production)
    end
end
