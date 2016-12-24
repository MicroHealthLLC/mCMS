class ApplicationMailer < ActionMailer::Base
  layout 'mailer'
  def mail(headers = {}, &block)
    headers.merge!(from: Setting['email_from'])
    super
  end
end
