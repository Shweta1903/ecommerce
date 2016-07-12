class CheckoutsController < ApplicationController
	before_action :authenticate_user!, only:[:index, :payment, :order_summary]

	def index
	  @addresses = current_user.addresses
	  @address = Address.new	
	end

	def new
      @address = Address.new	
	end

	def order_summary
		@user_cart = UserCart.find(session[:user_cart_id])
		@address = Address.find(params[:address_id])
		@amount = @user_cart.total_price
	end

	def payment
		#puts "=====================#{session[:user_cart_id].inspect}=================================="
		@user_cart = UserCart.find(session[:user_cart_id])
      	@order = Order.create(user_id: current_user.id, user_cart_id: session[:user_cart_id], total_amount: @user_cart.total_price, address_id: params[:address_id])
      	#p "================================================================#{@order.inspect}"
      	p @order.errors.messages
      	redirect_to @user_cart.paypal_url	   
	end

    def receipt
    	
    end

    def process_payment
		@user_cart = UserCart.find(session[:user_cart_id])
      	@order = Order.create(user_id: current_user.id, user_cart_id: session[:user_cart_id] = nil, total_amount: @user_cart.total_price, address_id: params[:address_id])
     	#render json: {success: true, total_price: user_cart.total_price}
    end
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