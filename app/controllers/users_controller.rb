class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_active_users

  def index
    @users = policy_scope(User).sort_by(&:first_name)

    if current_user.role == "tutor"
      @users = @users.select do |student|
        Course.where(tutor: current_user, student: student, status: 1).any?
      end
    end
  end

  def show
    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_active_users
    @active_users = "class=active"
  end
end
