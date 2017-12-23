class Image < ApplicationRecord
  # associations
  belongs_to :product, optional: true

  def image_name=(image)
    self.filename = image.original_filename
  end
end
