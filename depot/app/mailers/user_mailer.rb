class UserMailer < ApplicationMailer
  default from: 'Abhishek Kanojia <abhikanojiatest@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.created.subject
  #
  def created(user)
    @user = user

    mail to: @user.email, subject: 'Welcome to Pragmatic Store'
  end
end
