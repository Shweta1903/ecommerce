class AddColumnUserCartToCart < ActiveRecord::Migration
  def change
    add_reference :carts, :user_cart, index: true, foreign_key: true
  end
end
