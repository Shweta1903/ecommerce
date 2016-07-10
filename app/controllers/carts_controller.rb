class CartsController < ApplicationController
 # before_action :authenticate_user!

  def my_cart
    @user_cart = UserCart.find(session[:user_cart_id])
    if current_user.present?
      current_user.user_cart = @user_cart
      current_user.save!
    end
  end

  def add_to_cart
    p session[:user_cart_id]
    if params[:product_id].present?
      @product = Product.find(params[:product_id])
      @user_cart = UserCart.find(session[:user_cart_id])
      if current_user.present?
        current_user.user_cart = @user_cart
        current_user.save!
      end
      @cart = @user_cart.carts.create!(product_id: params[:product_id], quantity: 1)
    end
  end


  def change_quantity
    @cart = Cart.where(id: params[:cart_id]).first
     
    if (params[:change] == "plus")
      @cart.quantity = @cart.quantity + 1
    else
      @cart.quantity = @cart.quantity - 1
    end
    @cart.save
    render json: {success: true, quantity: @cart.quantity, price: @cart.quantity * @cart.product.discount_price }
  end



  def update_total_price
    user_cart = UserCart.find(session[:user_cart_id])
    user_cart.total_price = params[:total_price]
    user_cart.save
    render json: {success: true}
  end

  def destroy
    @cart = Cart.where(id: params[:cart_id]).first
     @cart.destroy
     render json: {success: true }
  end

end
