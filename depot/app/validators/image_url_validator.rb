class ImageUrlValidator < ActiveModel::EachValidator
  IMAGE_URL_REGEX = /\.(gif|jpg|png)\Z/i
  def validate_each(record, attribute, value)
    unless value =~ IMAGE_URL_REGEX
      record.errors.add attribute, 'must be a URL for GIF, JPG or PNG image.'
    end
  end
end
