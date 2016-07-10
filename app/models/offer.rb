class Offer < ActiveRecord::Base
  belongs_to :sale
  belongs_to :product

  validate :check_for_current_offer_on_product

  def check_for_current_offer_on_product
  	if status == "active"
	  	if product.current_offer.present? && product.current_sale.end_date >= Date.today 
	  		errors.add(:product, "Product has already an offer. set status to inactive for previous order to add new offer")
	  	elsif product.current_offer.present? && prdouct.current_sale.end_date < Date.today
	  		product.current_offer.status = "inactive"
	  		product.save
	  	end
    end
  end
end