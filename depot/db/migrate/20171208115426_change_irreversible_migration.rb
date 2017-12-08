class ChangeIrreversibleMigration < ActiveRecord::Migration[5.0]
  def change
    drop_table :irreversible_migration_examples do |t|
      t.string :zipcode
    end
  end
end
