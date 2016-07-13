class RemoveStateFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :state, :string
    remove_column :orders, :email, :string
    remove_column :orders, :phone_number, :string
  end
end
