class AddFilePathToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :filepath, :string
  end
end
