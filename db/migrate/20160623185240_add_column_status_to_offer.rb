class AddColumnStatusToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :status, :string
  end
end
