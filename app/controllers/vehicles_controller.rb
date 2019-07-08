class VehiclesController < ApplicationController
	def new
		@vehicle = current_user.build_vehicle
	end
	def create
		@vehicle = current_user.create_vehicle(vehicle_params)
		if @vehicle.save
			redirect_to vehicle_path(current_user,@vehicle)
		else
			render 'new'
		end 
	end
	def edit
		@vehicle = Vehicle.find(params[:id])
	end
	def update
		@vehicle = Vehicle.find(params[:id])
		@vehicle.update(vehicle_params)
		redirect_to vehicle_path(current_user,@vehicle)
	end
	def show
		@vehicle = Vehicle.find(params[:id])
	end
	def destroy
		@vehicle = Vehicle.find(params[:id])
		@vehicle.destroy
		redirect_to new_vehicle_path(current_user,@vehicle)	
	end	

	private
	def vehicle_params
		params.require(:vehicle).permit(:vehicle,:vehicle_name)
	end
end
