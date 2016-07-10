class AddColumnToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :total_amount, :integer
    add_column :orders, :phone_number, :string
    add_reference :orders, :address, index: true, foreign_key: true
    add_reference :orders, :user_cart, index: true, foreign_key: true
  end
end
