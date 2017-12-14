class UserMailer < ApplicationMailer
  default from: 'Abhishek Kanojia <abhikanojiatest@gmail.com>'

  def welcome_user(user)
    @user = user
    mail to: user.email, subject: 'Welcome User'
  end
end
