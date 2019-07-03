class CartItemsController < ApplicationController
	before_action :find_cart_item,  only: [:edit,:update,:destroy]
	def create
		@restaurant = RestaurantItem.find(params[:restaurant_item_id]).restaurant_id
		@cart_item = current_user.cart.cart_items.create({restaurant_item_id: params[:restaurant_item_id].to_i, num_of_item: params[:num_of_item].to_i})
		redirect_to add_path(restaurant_id: @restaurant)
	end
	def edit
	end
	def update
		@cart_item.update(params.permit(:num_of_item))
		redirect_to carts_path(current_user)
	end
	def destroy
		@cart_item.destroy
		redirect_back(fallback_location: root_path)
	end
	private
	def find_cart_item
		@cart_item = CartItem.find(params[:id])
	end
		
end