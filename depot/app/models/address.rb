class Address < ApplicationRecord
  validates :state, :country, :city, :pincode, presence: true
  validates :pincode, zipcode: true
end
