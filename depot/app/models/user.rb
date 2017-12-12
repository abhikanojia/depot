class User < ApplicationRecord
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: { with: EMAIL_REGEX, multiline: true, case_sensitive: false }
  has_secure_password

  after_destroy :ensure_an_admin_remains

  class Error < StandardError
  end

  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end
end
