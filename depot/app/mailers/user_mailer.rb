class UserMailer < ApplicationMailer
  def welcome_user(user)
    @user = user
    mail to: user.email, subject: 'Welcome User'
  end

  def consolidate_orders(user)
    @user = user
    @line_items = @user.line_items
    if @line_items.present?
      I18n.with_locale(@user.language_preference) do
        mail to: @user.email, subject: t('.subject')
      end
    else
      puts 'No Orders for this user.'
    end
  end
end
