class DeliveriesController < ApplicationController
	before_action :user_authentication
	def delivery
		@deliveries = current_user.vehicle.deliveries
	end
	def user_authentication
    unless user_signed_in?
      redirect_to root_path
    end
  end
end
