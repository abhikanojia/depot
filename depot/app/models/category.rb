class Category < ApplicationRecord
  scope :root_categories, -> { all }


  has_many :products, dependent: :restrict_with_error
  has_many :sub_categories, class_name: 'Category', foreign_key: 'parent_category_id'
  belongs_to :parent_category, class_name: 'Category'

  # callbacks
  after_create_commit :increment_count_in_parent_category

  def increment_count_in_parent_category
    Category.increment_counter(:count, parent_category.id)
  end
end
