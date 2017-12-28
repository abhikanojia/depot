class ImageCountValidator < ActiveModel::Validator
  MAX_IMAGES_ALLOWED = 3
  def validate(record)
    record.errors.add(:images, " must be #{MAX_IMAGES_ALLOWED} in number.") if record.product.images.count == MAX_IMAGES_ALLOWED
  end
end
