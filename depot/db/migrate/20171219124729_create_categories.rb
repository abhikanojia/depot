class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :count
      t.references :parent_category

      t.timestamps
    end
  end
end
