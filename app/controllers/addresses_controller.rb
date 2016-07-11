class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  
  def index
    @addresses = current_user.addresses
  end


  def show
    @address = Address.find(params[:id])
  end

  
  def new
    @address = Address.new
  end


  def edit
     @address = Address.find(params[:id])
  end


  def create
    @address = current_user.addresses.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to checkouts_path, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { redirect_to checkouts_path, notice: 'Address was not saved.' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to checkouts_path, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:first_name, :last_name, :address1, :address2, :contact_number, :city, :user_id)
    end
end
