class UserMailer < ActionMailer::Base
  default :from => "anshrox@to.com"

  def welcome_email(login)
    @login = login
    @url  = "http://localhost:3000/logins"
    mail(:to => login.email, :subject => "Welcome to My Awesome Site")
  end

  def forgot_password(param)
  	mail(:to => param[:email], :subject => "password reset mail")
  end
end
