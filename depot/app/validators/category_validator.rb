class CategoryValidator < ActiveModel::Validator
  def validate(record)
    if record.parent_id? && record.parent.parent_id?
      record.errors.add(:parent_id, "Cannot refer to subcategory.")
    end
  end
end
