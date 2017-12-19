class Category < ApplicationRecord
  scope :root_categories, -> { where(parent_category_id: nil) }

end
