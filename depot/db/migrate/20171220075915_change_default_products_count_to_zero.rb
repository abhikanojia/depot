class ChangeDefaultProductsCountToZero < ActiveRecord::Migration[5.0]
  def change
    change_column_default :categories, :products_count, from: nil, to: 0
  end
end
