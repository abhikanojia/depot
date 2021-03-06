class Category < ApplicationRecord
  scope :root_categories, -> { where(parent_id: nil) }

  # validations
  validates :name, presence: true
  validates :name, uniqueness: { scope: :parent_id }, allow_blank: true

  # associations
  has_many :products, dependent: :restrict_with_error
  has_many :sub_categories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Category', optional: true
  has_many :sub_category_products, through: :sub_categories, source: :products

  # callbacks
  validates_with CategoryValidator

  def recalculate_products_count
    self.products_count = count_products
    save
    parent.recalculate_products_count if parent.present?
  end


  def count_products
    category_ids = sub_category_ids << id
    Product.where(category_id: category_ids).count
  end
end
