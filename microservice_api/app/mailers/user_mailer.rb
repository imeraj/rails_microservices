class UserMailer < ApplicationMailer
  def send_confirmation(user)
    @user = user
    mail to: user.email, subject: "User created!"
  end
end
