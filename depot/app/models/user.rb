class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX, multiline: true }
  has_secure_password

  after_destroy :ensure_an_admin_remains
  before_destroy :ensure_not_destroying_admin
  before_update :ensure_not_updating_admin
  after_create_commit :send_welcome_email

  class Error < StandardError
  end

  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end

    def send_welcome_email
      UserMailer.welcome_user(self).deliver_now
    end

    def user_is_admin?
      self.email.eql? 'admin@depot.com'
    end

    def ensure_not_destroying_admin
      if user_is_admin?
        errors.add(:base, 'Cannot delete depot admin.')
        throw :abort
      end
    end

    def ensure_not_updating_admin
      if user_is_admin?
        errors.add(:base, 'Cannot update depot admin.')
        throw :abort
      end
    end
end
