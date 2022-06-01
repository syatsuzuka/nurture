class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_active_users

  def index
    @users = policy_scope(User).sort_by(&:first_name)
  end

  def show
    authorize @user
  end

  # def create
  #   @user = User.new(user_params)
  #   respond_to do |format|
  #     if @user.save
  #       # Tell the UserMailer to send a welcome email after save
  #       UserMailer.with(user: @user).welcome_email.deliver_now
  #       format.html { redirect_to(@user, notice: 'User was successfully created.') }
  #       format.json { render json: @user, status: :created, location: @user }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_active_users
    @active_users = "class=active"
  end
end
