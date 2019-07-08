class RolesController < ApplicationController
	before_action :validate_for_create, only: [:create]
	before_action :validate_to_access
	before_action :find_user_role, only: [:edit,:update,:destroy]
	def index
		@roles = current_user.roles
	end

	def new
		@role = current_user.roles.build
	end

	def create
		@role = current_user.roles.build(role_params)
		@role.save
		if current_user.roles.last.user_type == "restaurant"
			redirect_to new_restaurant_path(current_user)
		elsif current_user.roles.last.user_type == "delivery_patner"
			redirect_to new_vehicle_path(current_user)
		elsif current_user.roles.last.user_type == "user"
				current_user.create_cart
				redirect_to profile_path
		end
	end

	def edit
	end

	def update
		@role.update(role_params)
		redirect_to roles_path
	end

	def destroy
		if @role.user_type == "restaurant"
			@role.destroy
			current_user.restaurants.destroy
			redirect_to roles_path
		elsif @role.user_type == "delivery patner"
			# @role.destroy
			# redirect_to roles_path
		else
			@role.destroy
			redirect_to roles_path
		end	
	end

	private
	def role_params
		params.require(:role).permit(:user_type)
	end

	def find_user_role
		@role = current_user.roles.find(params[:id])
	end

	def validate_to_access
		unless user_signed_in?
			redirect_to root_path			
		end
	end
	def validate_for_create
		unless current_user.roles.select{|obj| obj.user_type == params[:role][:user_type]}.empty?
			redirect_to new_role_path(current_user)
		end
	end
end
