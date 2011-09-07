class UserMailer < ActionMailer::Base
  default :from => "ACM Class <sjtu.acm.class@gmail.com>"
  
  def welcome_email(user, passwd)
    @user = user
    @passwd = passwd
    mail(:to => user.email, :subject => "Welcome to ACM Class Website")
  end
end
