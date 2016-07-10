class UserCart < ActiveRecord::Base
  belongs_to :user
  has_many :carts


  def paypal_url(return_url) 
	values = {
		:business => 'shwetasingh0777-buyer@gmail.com',
	    :cmd => '_cart',
		:upload => 1,
		:return => return_url	
	}
	s_no = 1
	self.carts.each do |cart|
		values["amount_#{s_no}"] = cart.product.discount_price
		values["item_name_#{s_no}"] = cart.product.name
		values["item_number_#{s_no}"] = cart.product.id
		values["quantity_#{s_no}"] = cart.quantity
		s_no = s_no + 1
	end


    p values
	# values = { 
	# :business => 'shwetasingh0777-buyer@gmail.com',
 #        :cmd => '_cart',
	# :upload => 1,
	# :return => return_url,
	# "amount_1" => self.carts.first.product.discount_price,
	# "item_name_1" => self.carts.first.product.name,
	# "item_number_1" => self.carts.first.product.id,
	# "quantity_1" => self.carts.first.quantity,
	# "amount_2" => self.carts.last.product.discount_price,
	# "item_name_2" => self.carts.last.product.name,
	# "item_number_2" => self.carts.last.product.id,
	# "quantity_2" => self.carts.last.quantity
	# }	
    # For test transactions use this URL
	"https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
 end 
end
