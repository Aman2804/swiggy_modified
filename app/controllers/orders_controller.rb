class OrdersController < ApplicationController
	def index
		@orders = Order.where(restaurant_id: params[:restaurant_id]).includes(:order_items)
		# @restaurant = Restaurant.find(params[:restaurant_id])
		# @orders = Order.all.select{|order| order.restaurant_id == @restaurant.id}
		# @order_items = @orders.map{|obj|p obj.id}.map{|order_id| OrderItem.all.select{|order_item| order_item.order_id == order_id }}.flatten 
	end
	def create
		@order = current_user.orders.create(restaurant_id: params[:restaurant_id],status: "pending")
		current_user.cart.cart_items.pluck(:restaurant_item_id, :num_of_item).each do |id|
		@order.order_items.create(restaurant_item_id: id.first,quantity: id.last)
		end
		current_user.cart.cart_items.destroy_all
		redirect_to order_path(current_user,@order)
	end
	def update
		@order = Order.find(params[:id])
		@order.status = params[:value]
		@user = params[:users_id]
		@order.update(params.permit(:status))
		redirect_to orders_path(params[:users_id],restaurant_id: @order.restaurant_id)

	end
	def show
		@current_order = Order.find(params[:id])
		@order_items = @current_order.order_items.all
		@items = @order_items.map{|order_item| Item.find(RestaurantItem.find(order_item.restaurant_item_id).item_id) }
	end
	private
	def order_params
		params.require(:order).permit(:restaurant_id,:status,:user_id)
	end
end
