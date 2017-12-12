class Product < ApplicationRecord
  # constants
  PERMALINK_REGEX = /^[a-z0-9]+(?:-[a-z0-9]+){2,}/i
  DESCRIPTION_REGEX = /^\s*\S+(?:\s+\S+){4,9}\s*$/


  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item


  validates :title, :description, :image_url, :permalink, presence: true
  validates :permalink, uniqueness: true
  validates_format_of :permalink, with: PERMALINK_REGEX, multiline: true,
  message: 'Must be atleast 3 words separated by hyphens'
  validates_format_of :description, with: DESCRIPTION_REGEX, multiline: true,
  message: 'Must be of 5 to 10 words'
  validates :price, numericality: {greater_than_or_equal_to: 0.01}, if: 'price.present?'
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, url: true
  # validates :discount_price, with: :price_should_be_greater_than_discount_price
  validates :discount_price, discount_price: true


  private

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items Present')
    end
  end

  def price_should_be_greater_than_discount_price
    if discount_price > price
      errors.add(:discount_price, "cannot be more than price.")
    end
  end
end
