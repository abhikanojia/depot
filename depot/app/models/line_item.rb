class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, counter_cache: true
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  validates :product_id, uniqueness: { scope: :cart_id }

  def total_price
    product.price * quantity
  end
end
