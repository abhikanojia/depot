class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\.(gif|jpg|png)\Z/i
      record.errors.add attribute, 'must be a URL for GIF, JPG or PNG image.'
    end
  end
end

class DiscountPriceValidator < ActiveModel::Validator
  def validate(record)
    if record.discount_price > record.price
      record.errors.add :discount_price, 'cannot be more than price.'
    end
  end
end

class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  before_validation :set_default_title_if_title_is_empty, if: '!title?'
  before_validation :set_discount_price_if_discount_price_is_empty, if: '!discount_price?'


  validates :title, :description, :image_url, :permalink, presence: true
  validates :permalink, uniqueness: true
  validates_format_of :permalink, with: /^[a-z0-9]+(?:-[a-z0-9]+){2,}/i, multiline: true,
    message: 'Must be atleast 3 words separated by hyphens'
  validates_format_of :description, with: /^\s*\S+(?:\s+\S+){4,9}\s*$/, multiline: true,
    message: 'Must be of 5 to 10 words'
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, if: 'price.present?'
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, url: true
  # validates :discount_price, with: :price_should_be_greater_than_discount_price
  validates :discount_price, discount_price: true


  private

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items Present')
      throw :abort
    end
  end

  def price_should_be_greater_than_discount_price
    if discount_price > price
      errors.add(:discount_price, "cannot be more than price.")
      throw :abort
    end
  end

  def set_default_title_if_title_is_empty
    self.title = 'abc'
  end

  def set_discount_price_if_discount_price_is_empty
    self.discount_price = price
  end
end
