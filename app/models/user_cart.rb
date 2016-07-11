class UserCart < ActiveRecord::Base
  belongs_to :user
  has_many :carts


  def paypal_url(return_url) 
	values = {
		:business => 'shwetasingh-merchant@gmail.com',
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
	
    # For test transactions use this URL
	"https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
 end 
end
