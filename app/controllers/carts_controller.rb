class CartsController < ApplicationController
	before_action :user_authentication
	def index
		@cart_items = current_user.cart.cart_items
		@coupon = params[:coupon]
		if params[:per_off].present?
			@per_off = params[:per_off].first.to_i
		else
			@per_off = 0
		end
	end
	def user_authentication
    unless user_signed_in?
      redirect_to root_path
    end
  end
end
