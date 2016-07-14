class Cart < ActiveRecord::Base
  belongs_to :product
  belongs_to :user_cart
  
	validates :product_id,  :presence => true
	validates :quantity, numericality: { only_integer: true, greater_than: 0 }
     
end
