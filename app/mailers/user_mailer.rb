class UserMailer < ApplicationMailer
  # default from: 'seek@nurture-edu-app.quest'
  default from: ENV['MAIL_ADDRESS']

  def welcome_email
    @user = params[:user]
    @url  = ENV['SERVER_HOSTNAME']
    mail(to: @user.email, subject: 'Your Nurture account is now registered!')
  end

  def update_email
    @user = params[:user]
    @url  = ENV['SERVER_HOSTNAME']
    mail(to: @user.email, subject: 'Your Nurture account was updated!')
  end

  def invitation_email
    @user = params[:user]
    @tutor = params[:tutor]
    @course = params[:course]
    @url  = ENV['SERVER_HOSTNAME'] + params[:path]
    mail(to: @user.email, subject: 'You are invited to a new course!')
  end
end
