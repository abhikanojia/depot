class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.default_mail_from
  layout 'mailer'
end
