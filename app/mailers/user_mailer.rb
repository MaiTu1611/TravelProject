class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def welcome_email user
    @user = user
    @url  = 'http://example.com/login'
    attachments['RubyOnRails_V1.12.xlsx'] = File.read('public/files/RubyOnRails_V1.12.xlsx', mode: "rb")
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
