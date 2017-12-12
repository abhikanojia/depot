class DiscountPriceValidator < ActiveModel::Validator
  def validate(record)
    if record.discount_price > record.price
      record.errors.add :discount_price, 'cannot be more than price.'
    end
  end
end