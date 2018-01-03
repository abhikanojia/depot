class Rating < ApplicationRecord
  belongs_to :product

  def self.find_by_and_update_by_or_create(findparams, updateparams)
    rating = find_by(findparams)
    if rating.present?
      rating.update(updateparams)
    else
      rating = new(updateparams)
      rating.save
    end
  end
end
