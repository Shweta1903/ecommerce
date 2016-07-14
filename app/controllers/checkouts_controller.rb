class CheckoutsController < ApplicationController
	before_action :authenticate_user!, only:[:index, :payment, :order_summary]
	before_action :check_cart_items, only: [:index]

	def index
	  @addresses = current_user.addresses
	  @address = Address.new	
	end

	def new
      @address = Address.new	
	end

	def order_summary
		@user_cart = UserCart.find(session[:user_cart_id])
		if request.method == "POST"
	      	## we are using first_or_intialize because if someone needs to change the address for the current user_cart then duplicate order entry will not get created
	      	@order = Order.where(user_id: current_user.id, user_cart_id: session[:user_cart_id], total_amount: @user_cart.total_price).first_or_initialize
	      	@order.address_id = params[:address_id]
	      	@order.save
	    else
	    	@order = Order.where(user_cart_id: session[:user_cart_id]).first
	    	if !@order.present? || !@order.address_id.present?
	    		redirect_to my_cart_path
	    	end
	    end
	end

	def payment
		@user_cart = UserCart.find(session[:user_cart_id])
      	redirect_to @user_cart.paypal_url	   
	end

    def receipt
      @order = Order.where(user_cart_id: session[:user_cart_id]).first
      session[:user_cart_id] = nil
    end

    private
    def check_cart_items
      user_cart = UserCart.find(session[:user_cart_id])
      if user_cart.carts.count < 1
      	redirect_to my_cart_path
      end
    end

  #   def process_payment
		# @user_cart = UserCart.find(session[:user_cart_id])
  #     	@order = Order.create(user_id: current_user.id, user_cart_id: session[:user_cart_id] = nil, total_amount: @user_cart.total_price, address_id: params[:address_id])
  #    	#render json: {success: true, total_price: user_cart.total_price}
  #   end
end









# Parameters: {"utf8"=>"✓", "authenticity_token"=>"5L+IXy75LObH/QE3DA6TTijqgjl5EpUg2mirgBGYiEkxUgDTG/TYlhHslLsBFtVczFp1s3JfhDeuGcXip/Lm4A==", 
# 	"stripeToken"=>"tok_18SJNlC1Gah5Rx9mLc6k9PJZ", "stripeTokenType"=>"card", "stripeEmail"=>"1519shwetasingh@gmail.com"}



# if stripe_token = params[:stripe_token]
#           if current_user.paid(params[:payment_type], stripe_token)
#             flash[:notice] = 'Card charged successfully'
#           else
#           flash[:alert] = 'Some error happened while charging you, please double check your card details'
#           end
#         else
#           flash[:alert] = 'You did not submit the form correctly'
#         end

#          redirect_to checkouts_path