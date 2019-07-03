class ItemsController < ApplicationController
	before_action :check_user_role
	before_action :find_item,only: [:edit,:update,:destroy]
	def index
		# @restaurant_id = params[:restaurant_id]
		@items = Item.all
	end
	def new
		@item = Item.new
	end
	def create
		@item = Item.create(item_params)
		if @item.save
			redirect_to items_path
		else
			render 'new'
		end	
	end
	def edit
	end
	def update
		@item.update(item_params)
		redirect_to items_path
	end
	def destroy
		@item.destroy
		redirect_to items_path
	end
	private
	def item_params
		params.require(:item).permit(:name,:category,:type_of_dish)
	end
	def check_user_role
		if current_user.roles.select{|role| role.user_type == "restaurant"}.empty? 
			redirect_to profile_path
		end
	end
	def find_item
		@item = Item.find(params[:id])
	end
end
