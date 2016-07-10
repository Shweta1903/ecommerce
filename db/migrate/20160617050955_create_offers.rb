class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :sale, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
