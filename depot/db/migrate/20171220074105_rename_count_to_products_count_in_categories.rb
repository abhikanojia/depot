class RenameCountToProductsCountInCategories < ActiveRecord::Migration[5.0]
  def change
    rename_column :categories, :count, :products_count
  end
end
