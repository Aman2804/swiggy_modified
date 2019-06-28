class AddressesController < ApplicationController
  def index
    @addresses = current_user.addresses
  end

  def new
    @address = current_user.addresses.new
  end
  
  def create
    @address = current_user.addresses.new(address_permited_params)
    if @address.save
      redirect_to addresses_path
    else
      render 'new'
    end
  end
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = current_user.address.find(params[:id])
    if @address.update(address_permited_params)
      redirect_to addresses_path
    else
      render 'edit'
    end
  end

  private

  def address_permited_params
    params.require(:address).permit(:flat_no, :location, :city, :landmark, :address_type)
  end

end
