class Order < ApplicationRecord
  # relationship
  has_many :line_items, dependent: :destroy
  belongs_to :user

  enum pay_type: {
    "Check" => 0,
    "Credit Card" => 1,
    "Purchase order" => 2
  }

  # validations
  validates_presence_of :name, :address, :email
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      line_items << item
    end
  end

  def gross_total
    total_amount = 0
    line_items.each do |line_item|
      total_amount += line_item.total_price
    end
    total_amount
  end
end
