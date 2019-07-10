class RestaurantItemsController < ApplicationController
	before_action :user_authentication
	def new
		@item = Item.all
		@restaurant = Restaurant.find(params[:restaurants_id])
		@restaurant_item = @restaurant.restaurant_items.build
	end

	def create
		@restaurant = Restaurant.find(params[:restaurants_id])
		@restaurant_item = @restaurant.restaurant_items.build
		@restaurant_item[:item_id] = params[:restaurant_item][:item].to_i
		@restaurant_item[:price] =  params[:restaurant_item][:price].to_i
		@restaurant_item.save
		redirect_to new_restaurant_item_path(@restaurant)
	end
	def destroy
		RestaurantItem.find(params[:id]).destroy
		redirect_to restaurant_path(current_user,params[:restaurants_id])
	end
	private
	def user_authentication
    unless user_signed_in?
      redirect_to root_path
    end
  end
end
 