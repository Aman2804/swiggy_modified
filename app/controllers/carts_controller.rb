class CartsController < ApplicationController
	def index
		@restaurant = current_user.cart.cart_items.first.restaurant_item_id
		@cart_items = current_user.cart.cart_items.all
		@total = 0
	end
	def edit
		@restaurant = current_user.cart.cart_items.first.restaurant_item_id
		@cart_items = current_user.cart.cart_items.all
	end
	def update
		@cart_item = CartItem.find(params[:cart_item_id])
		@cart_item.num_of_item = params[:item]
		@cart_item.update(params.permit(:num_of_item))
		redirect_to carts_path(current_user)
	end
end
