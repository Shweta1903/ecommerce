class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
 

  before_filter :store_location

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    if session[:user_cart_id].present?
      current_user.user_cart = UserCart.find(session[:user_cart_id])
      current_user.save
    end
    session[:previous_url] || root_path
  end

  def after_sign_up_path_for(resource)
    if session[:user_cart_id].present?
      current_user.user_cart = UserCart.find(session[:user_cart_id])
      current_user.save
    end
    session[:previous_url] || root_path
  end

   # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
