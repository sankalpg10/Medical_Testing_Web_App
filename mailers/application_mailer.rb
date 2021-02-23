class ApplicationMailer < ActionMailer::Base
  default from: 'labu.dev.123@gmail.com'
  def send_welcome_email(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome!")
  end
  #  layout 'mailer'
end
