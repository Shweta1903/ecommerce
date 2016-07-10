class AddPriceToUserCart < ActiveRecord::Migration
  def change
    add_column :user_carts, :total_price, :integer
  end
end
