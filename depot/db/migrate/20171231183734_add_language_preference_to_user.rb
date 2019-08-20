class AddLanguagePreferenceToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :language_preference, :string, default: 'en'
  end
end
