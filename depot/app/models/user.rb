class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: { with: /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i, multiline: true }
  has_secure_password

  before_update :ensure_user_is_not_admin

  before_destroy :ensure_user_is_not_admin
  after_destroy :ensure_an_admin_remains

  class Error < StandardError
  end

  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end

    def ensure_user_is_not_admin
      errors.add(:base, "Cannot alter admin.")
      throw :abort if self.email.eql? 'admin@depot.com'
    end
end
