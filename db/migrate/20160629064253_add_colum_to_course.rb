class AddColumToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :name, :string
    add_column :courses, :price, :integer
  end
end
