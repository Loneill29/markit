ActionMailer::Base.smtp_settings = {
  port:              587,
  address:           'smtp.mailgun.org',
  user_name:         ENV['MAILGUN_SMTP_LOGIN'],
  password:          ENV['MAILGUN_SMTP_PASSWORD'],
  domain:            'https://api.mailgun.net/v3/sandboxf31a46b63ca74b9fa8d4d43b9ebe3e1a.mailgun.org',
  authentication:    :plain,
  content_type:      'text/html'
}
ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.raise_delivery_errors = true

# http://edgeguides.rubyonrails.org/action_mailer_basics.html#intercepting-emails
class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.to =  'oneill.linda21@gmail.com'
    message.cc = nil
    message.bcc = nil
  end
end

# Locally, outgoing mail will be 'intercepted' by the
# above DevelopmentMailInterceptor before going out
if Rails.env.development?
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)
end