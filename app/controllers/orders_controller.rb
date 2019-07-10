class OrdersController < ApplicationController
	before_action :user_authentication
	def index
		@orders = Order.where(restaurant_id: params[:restaurant_id].to_i).includes(:order_items)
	end
	def create
		cart_items = current_user.cart.cart_items
		@order_ids = Array.new
		params[:restaurants_id].each do |restaurantid|
			@order = current_user.orders.create(restaurant_id: restaurantid,status: "pending")
			cart_items.select{|obj| obj.restaurant_item.restaurant_id == restaurantid.to_i }.pluck(:restaurant_item_id, :num_of_item).each do |id|
				@order.order_items.create(restaurant_item_id: id.first, quantity: id.last)
				@order_ids << @order.id
			end
		end
		cart_items.destroy_all
		redirect_to order_path(current_user,@order_ids)
	end
	def update
		@order = Order.find(params[:id])
		@order.status = params[:value]
		vehicle_id = Vehicle.ids.sample
		@order.update(params.permit(:status))
		if params[:value] == "Accept" && @order.delivery.nil?
			@order.create_delivery(status: "Not delivered",vehicle_id: vehicle_id)
		elsif @order.delivery.present? && params[:value] == "Reject"
			 	@order.delivery.destroy
		end
		redirect_to orders_path(params[:users_id],restaurant_id: @order.restaurant_id)
	end
	def show
		@current_orders = current_user.orders.select{|order| order.status == "pending" || order.status == "Accept"}
	end
	private
	def order_params
		params.require(:order).permit(:restaurant_id,:status,:user_id)
	end
	def user_authentication
    unless user_signed_in?
      redirect_to root_path
    end
  end
end
 