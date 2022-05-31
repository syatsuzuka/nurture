class UserMailer < ApplicationMailer
  # default from: 'seek@nurture-edu-app.quest'
  default from: ENV['MAIL_ADDRESS']

  def welcome_email
    @user = params[:user]
    @url  = ENV['SERVER_HOSTNAME'] + params[:path]
    mail(to: @user.email, subject: 'Your Nurture account is now registered!')
  end
end
