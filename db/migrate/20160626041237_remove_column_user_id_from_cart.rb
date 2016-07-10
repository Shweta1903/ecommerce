class RemoveColumnUserIdFromCart < ActiveRecord::Migration
  def change
    remove_column :carts, :user_id, :string
  end
end
