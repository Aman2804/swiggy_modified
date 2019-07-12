class RestaurantsController < ApplicationController
	before_action :user_authentication
	before_action :check_user_type
	def index
		@restaurants = current_user.restaurants
	end
	def new
		@restaurant = current_user.restaurants.build
	end
	def create
		@restaurant = current_user.restaurants.build(restaurants_params)
		@restaurant.save
		if @restaurant.save
			redirect_to new_restaurants_address_path(@restaurant)
		else
			render 'new'
		end
	end
	def edit
		@restaurant = current_user.restaurants.find(params[:id])
	end
	def show
		@restaurant = Restaurant.find(params[:id])
		@items = Item.all
	end
	def update
		current_user.restaurants.find(params[:id]).update(restaurants_params)
		redirect_to restaurants_path
	end
	def destroy
		current_user.restaurants.find(params[:id]).destroy
		redirect_to restaurants_path
	end
	private
	def restaurants_params
		params.require(:restaurant).permit(:designation, :item_id,:name)		
	end
	def check_user_type
		if current_user.roles.select{|role| role.user_type == "restaurant"}.empty?
			redirect_to profile_path
		end
	end
	def user_authentication
    unless user_signed_in?
      redirect_to root_path
    end
  end
end
