module StoreHelper
  def average_rating(product)
    rating = product.average_rating
    rating > 0 ? number_with_precision(rating, precision: 2) : "Be the First to rate."
  end
end
