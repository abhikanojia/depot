class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item


  validates :title, :description, :image_url, :permalink, presence: true
  validates :permalink, uniqueness: true
  validates_format_of :permalink, with: /^[a-z0-9]+(?:-[a-z0-9]+){2,}/i, multiline: true,
    message: 'Must be atleast 3 words separated by hyphens'
  validates_format_of :description, with: /^\s*\S+(?:\s+\S+){4,9}\s*$/, multiline: true,
    message: 'Must be of 5 to 10 words'
  validates :price, numericality: {greater_than_or_equal_to: 0.01}, if: 'price.present?'
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: { with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  private

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items Present')
      throw :abort
    end
  end
end
