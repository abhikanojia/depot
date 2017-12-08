class ChangeDefaultValueOfEnabled < ActiveRecord::Migration[5.0]
  def change
    change_column_default :products do |t|
      t.boolean :enabled, false
    end
  end
end
