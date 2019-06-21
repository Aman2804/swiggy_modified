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
    @role = current_user.roles.build
    @role.user_type = params[:user_type]
    @role.save
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
    @user = current_user
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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute,:name,:contact,:gender,:city,:role])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute,:name,:contact,:gender,:city,:role])
  end
  def session_check
    unless user_signed_in?
      redirect_to root_path
    end
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    new_restaurant_path(current_user)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
