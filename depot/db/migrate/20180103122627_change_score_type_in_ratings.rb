class ChangeScoreTypeInRatings < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      change_table :ratings do |t|
        dir.up { t.change :score, :decimal, precision: 1, scale: 1, default: 0.0 }
        dir.down { t.change :score, :integer, default: 0 }
      end
    end
  end
end
