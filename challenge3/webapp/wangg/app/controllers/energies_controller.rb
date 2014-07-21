class EnergiesController < ApplicationController
	before_action :confirm_logged_in, :except=>[:index]
	
	def index
		@energies=Energy.all
	end
	
	def new
	    @energy=Energy.new
    end

    def create
    	# Instantiate a new object using form parameters
    	@energy=Energy.new(energy_params)
	    # Save the object
	    if @energy.save
	      # If save succeeds, redirect to the index action
	      flash[:notice]="saved sucessfully"
	      redirect_to(:action=>'index')
	    else
	      # If save fails, redisplay the form so user can fix problems
	      render('new')
	    end
	end

    def edit
    	@energy=Energy.find(params[:id])
    end

    def update
	    # Find an existing object using form parameters
	    @energy=Energy.find(params[:id])
	    
	    # Update the object
	    if @energy.update_attributes(energy_params)
	      # If update succeeds, redirect to the index action
	      flash[:notice]="updated successfully"
	      redirect_to(:action=>'index')
	    else
	      # If update fails, redisplay the form so user can fix problems
	      render('edit')
	    end
	end

  	def delete
    	@energy=Energy.find(params[:id])
  	end

  	def destroy
    	energy=Energy.find(params[:id]).destroy
    	flash[:notice]="Energy Record #{energy.id} destroyed successfully"
    	redirect_to(:action=>'index')
	end

	private
	    def energy_params
	      params.require(:energy).permit(:label,:house_id,:year,:month,:temperature,:daylight,:energy_production)
    end
end
