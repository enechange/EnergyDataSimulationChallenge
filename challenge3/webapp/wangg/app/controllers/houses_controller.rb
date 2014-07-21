class HousesController < ApplicationController
	before_action :confirm_logged_in, :except=>[:index, :show]
	def index
		@houses=House.all
	end

	def show
		@house=House.find(params[:id])
		@energies=@house.energies
	end

	def new
	    @house=House.new
    end

    def create
    	# Instantiate a new object using form parameters
    	@house=House.new(house_params)
	    # Save the object
	    if @house.save
	      # If save succeeds, redirect to the index action
	      flash[:notice]="saved sucessfully"
	      redirect_to(:action=>'index')
	    else
	      # If save fails, redisplay the form so user can fix problems
	      render('new')
	    end
	end

    def edit
    	@house=House.find(params[:id])
    end

    def update
	    # Find an existing object using form parameters
	    @house=House.find(params[:id])
	    
	    # Update the object
	    if @house.update_attributes(house_params)
	      # If update succeeds, redirect to the index action
	      flash[:notice]="updated successfully"
	      redirect_to(:action=>'index')
	    else
	      # If update fails, redisplay the form so user can fix problems
	      render('edit')
	    end
	end

  	def delete
    	@house=House.find(params[:id])
  	end

  	def destroy
    	house=House.find(params[:id]).destroy
    	flash[:notice]="House #{house.id} destroyed successfully"
    	redirect_to(:action=>'index')
	end

	private
	    def house_params
	      params.require(:house).permit(:first_name,:last_name,:city,:num_of_people,:has_child)
    end
end
