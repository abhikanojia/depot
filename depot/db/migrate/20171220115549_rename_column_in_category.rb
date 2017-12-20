class RenameColumnInCategory < ActiveRecord::Migration[5.0]
  def change
    rename_column :categories, :parent_category_id, :parent_id
  end
end
