class Category < ApplicationRecord
  scope :root_categories, -> { where(parent_category_id: nil) }

  # validations
  validates :name, presence: true
  validates :name, uniqueness: { scope: :parent_category_id }, allow_blank: true
  validates_uniqueness_of :name, if: :name?

  # associations
  has_many :products, dependent: :restrict_with_error
  has_many :sub_categories, class_name: 'Category', foreign_key: 'parent_category_id'
  belongs_to :parent_category, class_name: 'Category'
  has_many :sub_category_products, through: :sub_categories, source: :products

  # callbacks
  before_destroy :ensure_no_products_exists
  after_create_commit :increment_count_in_parent_category
  before_save :ensure_not_referring_to_sub_category

  def sub_category_exists?
    !sub_categories.empty?
  end

  private

    def increment_count_in_parent_category
      Category.increment_counter(:products_count, parent_category.id)
    end

    def ensure_no_products_exists
      if !products.empty?
        errors.add(:base, 'Product exists in this category.')
        throw :abort
      end
    end

    def ensure_not_referring_to_sub_category
      if Category.find(parent_category_id).parent_category_id?
        errors.add(:base, "Cannot refer to subcategory.")
        throw :abort
      end
    end
end
