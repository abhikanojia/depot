class ZipcodeValidator < ActiveModel::EachValidator
  ZIPCODE_REGEX = /^[0-9]{3,10}/
  def validate_each(record, attribute, value)
    unless value.to_s.match? ZIPCODE_REGEX
      record.errors.add attribute, 'Must be a valid.'
    end
  end
end