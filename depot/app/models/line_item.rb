class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  validates_uniqueness_of :product_id, scope: [:cart_id]

  def total_price
    product.price * quantity
  end
end
