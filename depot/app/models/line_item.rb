class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order, optional: true
  belongs_to :product, optional: true

  def total_price
    product.price * quantity
  end
end
