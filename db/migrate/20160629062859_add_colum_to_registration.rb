class AddColumToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :name, :string
    add_column :registrations, :contact, :string
    add_reference :registrations, :course, index: true, foreign_key: true
  end
end
