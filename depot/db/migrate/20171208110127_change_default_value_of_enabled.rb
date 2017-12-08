class ChangeDefaultValueOfEnabled < ActiveRecord::Migration[5.0]
  def change
    change_column_default :products, :enabled, false
  end
end
