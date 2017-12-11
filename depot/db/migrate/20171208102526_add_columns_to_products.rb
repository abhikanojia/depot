class AddColumnsToProducts < ActiveRecord::Migration[5.0]
  def change
    change_table :products, bulk: true do |t|
      t.boolean :enabled
      t.string :permalink
      t.decimal :discount_price
    end
  end
end
