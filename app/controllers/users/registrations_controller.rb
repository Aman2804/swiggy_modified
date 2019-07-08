# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :session_check ,except: [:create,:new]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource 
  def create
    super
    # if current_user.roles.first.user_type == "restaurant"
    #   new_restaurant_path
    # else
    #   profile_path
    # end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end
  #profile
  def show
  end
  def add
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_items = RestaurantItem.all.map{|restaurant_item| restaurant_item.item_id if restaurant_item.restaurant_id == @restaurant.id}
    @items = Item.find(@restaurant_items)
    
  end
  def restaurants_list
    @restaurants = Restaurant.all
  end
  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute,:name,:contact,:gender,:city,:user_type])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute,:name,:contact,:gender,:city,:user_type])
  end
  def session_check
    unless user_signed_in?
      redirect_to root_path
    end
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    binding.pry
    if params[:user][:user_type] == "delivery_patner"
      new_vehicle_path(current_user)
    elsif params[:user][:user_type] == "restaurant"
      new_restaurant_path(current_user)
    else
      profile_path
    end
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
