class OrdersController < ApplicationController
   before_action :authenticate_user!

    protect_from_forgery except: [:hook]
  
    def hook
      params.permit! # Permit all Paypal input params
      status = params[:payment_status]
      if status == "Completed"
        @order = Order.find params[:invoice]
        @order.update_attributes(transaction_id: params[:txn_id], purchased_at: Time.now)
      end
    render nothing: true
    end

  def index
  	@user_cart = UserCart.find(session[:user_cart_id])
    @orders = Order.all
  end

  def show
  	@order = Order.find(params[:id])
  end


  def new
    @order = Order.new
  end


  def edit
  	@order = Order.find(params[:id])
  end

  
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @order.update(order_params.merge(status: 'submitted'))
        format.html { redirect_to confirm_order_path(@order), notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
  	@order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to products_path }
      format.json { head :no_content }
    end
  end

  private

    def order_params
      params.require(:order).permit(:email, :state, :user_id, :total_amount, :phone_number, :address_id, :user_cart_id)
    end
end
