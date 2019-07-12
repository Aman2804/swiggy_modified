class AddressesController < ApplicationController
  before_action :user_authentication
  before_action :check_request_owner

  def index
    @addresses = @role_address
  end

  def new
    @address = @role_new
  end
  
  def create
    if @role_create.save
      if @role.to_s == "User"
        redirect_to addresses_path
      else
        redirect_to restaurants_address_path(@role_create.addressable_id,@role_create)
      end
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    @address = Address.find(params[:id])
  end
  
  def update
      if @role.to_s == "User"
        @role_address.find(params[:id]).update(address_permited_params)
        redirect_to addresses_path(current_user)
      else
        @role_address.update(address_permited_params)
        redirect_to restaurants_address_path(@role_address.addressable_id,@role_address)
      end
  end

  def destroy
    if @role.to_s == "User"
      @role_address.find(params[:id]).destroy
        redirect_to addresses_path(current_user)
    else
      @role_address.destroy
      flash[:notice] = "You have to register a new address"
      redirect_to new_restaurants_address_path(@role_address.addressable_id)
    end
  end

  private

  def address_permited_params
    params.require(:address).permit(:flat_no, :location, :city, :landmark, :address_type)
  end
  
  def user_authentication
    unless user_signed_in?
      redirect_to root_path
    end
  end
  
  def check_request_owner
    @role = request.path.split("/")[1].capitalize.singularize.constantize
    role_id = request.path.split("/")[2].to_i
    if @role.to_s == "User"
      @role_address = @role.find(role_id).addresses
      @role_new = @role.find(role_id).addresses.build
      @role_create = @role.find(role_id).addresses.build(address_permited_params) if request.headers[:REQUEST_METHOD] == "POST"
    else
      @role_address = @role.find(role_id).address
      @role_new = @role.find(role_id).build_address unless @role_address.present?
      @role_create = @role.find(role_id).build_address(address_permited_params) if request.headers[:REQUEST_METHOD] == "POST"
    end
  end

end
