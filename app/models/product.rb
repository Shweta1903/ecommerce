  class Product < ActiveRecord::Base
  mount_uploader :thumbnail, ThumbnailUploader
  

  has_one :current_offer, -> { where(status: 'active') }, class_name: 'Offer'
  has_one :current_sale, class_name: 'Sale', through: :current_offer, source: 'sale'
  has_many :offers
  has_many :sales, through: :offers

  belongs_to :category
  has_many :carts

  has_many :order_products
  has_many :orders, through: :order_products

   validates :name, :description, :thumbnail, :quantity, :price, :category_id,   :presence => true

  def discount_price
  	sale = self.current_sale
  	if sale.present? && sale.start_date <= Date.today && sale.end_date >= Date.today
  		price - (price * (sale.discount_percentage.to_f/100))
  	else
  		price
  	end
  end

  def is_already_added(user_cart_id)
    if user_cart_id.present?
      cart = self.carts.where(user_cart_id: user_cart_id).first
      if cart.present?
        return true
      end
    end
    return false
  end
end







