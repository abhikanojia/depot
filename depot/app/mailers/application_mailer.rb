class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secret.default_mail_from
  layout 'mailer'
end
