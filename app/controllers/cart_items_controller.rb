class CartItemsController < ApplicationController
	before_action :find_cart_item,  only: [:edit,:update,:destroy]
	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		@restaurant_item = @restaurant.restaurant_items.select{|item| item.item_id == params[:item_id].to_i}.first
		@cart_item = current_user.cart.cart_items.build({restaurant_item_id: @restaurant_item.id, num_of_item: params[:num_of_item].to_i})
		@cart_item.save
		redirect_to add_path(restaurant_id: @restaurant.id)
	end
	def edit
	end
	def update
		@cart_item.update(params.permit(:num_of_item))
		redirect_to carts_path(current_user)
	end
	def destroy
		@cart_item.destroy
		redirect_to carts_path(current_user)
	end
	private
	def find_cart_item
		@cart_item = CartItem.find(params[:id])
	end
		
end