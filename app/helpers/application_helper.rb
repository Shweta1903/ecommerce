module ApplicationHelper
	def get_current_cart
		if session[:user_cart_id].present?
			user_cart = UserCart.find(session[:user_cart_id])
			item_count = user_cart.carts.count
		else
			user_cart = UserCart.create
			session[:user_cart_id] = user_cart.id
			item_count = 0
		end
		item_count 
	end
end
