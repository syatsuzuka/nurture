class UserMailer < ApplicationMailer
  # default from: 'seek@nurture-edu-app.quest'
  default from: ENV.fetch('MAIL_ADDRESS')

  def welcome_email
    @user = params[:user]
    @url  = ENV.fetch('SERVER_HOSTNAME')
    I18n.with_locale(@user.locale) do
      mail(to: @user.email, subject: I18n.t('user_mailer.welcome_email.text_subject'))
    end
  end

  def update_email
    @user = params[:user]
    @url  = ENV.fetch('SERVER_HOSTNAME')
    I18n.with_locale(@user.locale) do
      mail(to: @user.email, subject: I18n.t('user_mailer.update_email.text_subject'))
    end
  end

  def invitation_email
    @user = params[:user]
    @tutor = params[:tutor]
    @course = params[:course]
    @url = ENV.fetch('SERVER_HOSTNAME') + params[:path]
    I18n.with_locale(@user.locale) do
      mail(to: @user.email, subject: I18n.t('user_mailer.invitation_email.text_subject'))
    end
  end

  def notify_message_email
    @user = params[:user]
    @from = params[:from]
    @course = params[:course]
    @message_count = params[:message_count]
    @url = ENV.fetch('SERVER_HOSTNAME') + params[:path]

    # puts "to: #{@user.email}, from: #{@from.first_name}, course: #{@course.name}"
    I18n.with_locale(@user.locale) do
      mail(
        to: @user.email,
        subject: "You've got #{@message_count} messages from #{@from.first_name} in '#{@course.name}'!"
      )
    end
  end

  def closing_course_email
    @user = params[:user]
    @tutor = params[:tutor]
    @course = params[:course]
    @url = ENV.fetch('SERVER_HOSTNAME') + params[:path]
    I18n.with_locale(@user.locale) do
      mail(to: @user.email, subject: I18n.t('user_mailer.closing_course_email.text_subject', course_name: @course))
    end
  end
end
