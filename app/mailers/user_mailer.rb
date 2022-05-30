class UserMailer < ApplicationMailer
  default from: 'oshtemo@playfunplus.com'

  def welcome_email
    @user = params[:user]
    @url  = 'https://nurture-lw.herokuapp.com/dashboard'
    mail(to: @user.email, subject: 'Your Nurture account is now registered!')
  end
end
