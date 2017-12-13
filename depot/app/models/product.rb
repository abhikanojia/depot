class Product < ApplicationRecord
  # constants
  PERMALINK_REGEX = /^[a-z0-9]+\-?[a-z0-9]+$/i

  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item


  validates :title, presence: true, uniqueness: true
  validates :image_url, presence: true, allow_blank: true, image_url: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, allow_nil: true
  validates :discount_price, numericality: { less_than: -> (product) { product.price } }, if: 'price.present?'
  validates :permalink, presence: true, uniqueness: true, length: {
    minimum: 3,
    case_sensitive: false,
    tokenizer: lambda { |permalink| permalink.scan(/\w+\-?/) },
    message: 'Must be atleast 3 words separated by hyphens.'
  }, format: {
    with: PERMALINK_REGEX,
    multiline: true,
    message: 'must not contain spaces and special characters other than hyphen between 2 words.'
  }
  validates :description, presence: true, length: {
    minimum: 5,
    maximum: 10,
    tokenizer: lambda { |description| description.scan(/\w+/) },
    too_short: 'Must have atleast 5 words',
    too_long: 'Must have atmost 10 words'
  }
  # validates :discount_price, with: :validate_price_greater_than_discount


  private

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
