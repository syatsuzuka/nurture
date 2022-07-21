class UserMailer < ApplicationMailer
  # default from: 'seek@nurture-edu-app.quest'
  default from: ENV.fetch('MAIL_ADDRESS')

  def welcome_email
    @user = params[:user]
    @url  = ENV.fetch('SERVER_HOSTNAME')
    mail(to: @user.email, subject: 'Your Nurture account is now registered!')
  end

  def update_email
    @user = params[:user]
    @url  = ENV.fetch('SERVER_HOSTNAME')
    mail(to: @user.email, subject: 'Your Nurture account was updated!')
  end

  def invitation_email
    @user = params[:user]
    @tutor = params[:tutor]
    @course = params[:course]
    @url = ENV.fetch('SERVER_HOSTNAME') + params[:path]
    mail(to: @user.email, subject: 'You are invited to a new course!')
  end

  def closing_course_email
    @user = params[:user]
    @tutor = params[:tutor]
    @course = params[:course]
    @url = ENV.fetch('SERVER_HOSTNAME') + params[:path]
    mail(to: @user.email, subject: "'#{@course}' was closed")
  end
end
