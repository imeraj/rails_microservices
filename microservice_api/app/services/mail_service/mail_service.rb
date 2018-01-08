class MailService < ActionMailer::Base
  def send_email(from, to, subject, body)
    opts = { from: from, to: to, subject: subject, body: body}
    email = mail opts
    !!email.deliver
  end
end
