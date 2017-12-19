class Product < ApplicationRecord
  # constants
  PERMALINK_REGEX = /\A[^\s!#$%^&*()（）=+;:'"\[\]\{\}|\\\/<>?,]+\z/i
  DEFAULT_TITLE = 'abc'

  has_many :line_items, dependent: :restrict_with_error
  has_many :orders, through: :line_items
  has_many :carts, through: :line_items
  # before_destroy :ensure_not_referenced_by_any_line_item

  before_validation :set_default_title, unless: :title?
  before_validation :set_default_discount_price, unless: :discount_price?

  validates :title, presence: true, uniqueness: true
  validates :image_url, presence: true, allow_blank: true, image_url: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, allow_nil: true
  validates :discount_price, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: -> (product) { product.price } }, allow_nil: true
  validates :permalink, uniqueness: { case_sensitive: false }, format: { with: PERMALINK_REGEX }
  validates_length_of :words_in_permalink, minimum: 3, message: 'Must be atleast 3 words'
  validates :description, presence: true
  validates_length_of :words_in_description, minimum: 5, maximum: 10,
    too_short: 'Must have atleast 5 words',
    too_long: 'Must be atmost 10 words'
  # validates :discount_price, with: :validate_price_greater_than_discount

  private

  def set_default_discount_price
    self.discount_price = price
  end

  def set_default_title
    self.title = DEFAULT_TITLE
  end

  def words_in_description
    description.scan(/\w+/)
  end

  def words_in_permalink
    permalink.scan(/\w+\-?/)
  end

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items Present')
    end
  end

  def validate_price_greater_than_discount
    if discount_price > price
      errors.add(:discount_price, "cannot be more than price.")
    end
  end
end
