class Order < ApplicationRecord
  # relationship
  has_many :line_items, dependent: :destroy
  belongs_to :user

  # scope
  scope :by_date, ->(from = Time.now.beginning_of_day, to = Time.now.end_of_day) { where(created_at: from..to) }

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
    line_items.inject(0) { |total_amount, item| total_amount += item.total_price }
  end
end
