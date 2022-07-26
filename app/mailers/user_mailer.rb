class UserMailer < ApplicationMailer
  # default from: 'seek@nurture-edu-app.quest'
  default from: ENV.fetch('MAIL_ADDRESS')

  def welcome_email
    @user = params[:user]
    @url  = ENV.fetch('SERVER_HOSTNAME')
    mail(to: @user.email, subject: I18n.t('user_mailer.welcome_email.text_subject'))
  end

  def update_email
    @user = params[:user]
    @url  = ENV.fetch('SERVER_HOSTNAME')
    mail(to: @user.email, subject: I18n.t('user_mailer.update_email.text_subject'))
  end

  def invitation_email
    @user = params[:user]
    @tutor = params[:tutor]
    @course = params[:course]
    @url = ENV.fetch('SERVER_HOSTNAME') + params[:path]
    mail(to: @user.email, subject: 'You are invited to a new course!')
  end

  def notify_message_email
    @user = params[:user]
    @from = params[:from]
    @course = params[:course]
    @message_count = params[:message_count]
    @url = ENV.fetch('SERVER_HOSTNAME') + params[:path]

    puts "to: #{@user.email}, from: #{@from.first_name}, course: #{@course.name}"
    mail(
      to: @user.email,
      subject: "You've got #{@message_count} messages from #{@from.first_name} in '#{@course.name}'!"
    )
  end

  def closing_course_email
    @user = params[:user]
    @tutor = params[:tutor]
    @course = params[:course]
    @url = ENV.fetch('SERVER_HOSTNAME') + params[:path]
    mail(to: @user.email, subject: "'#{@course}' was closed")
  end
end
