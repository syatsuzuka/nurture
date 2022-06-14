class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_active_users

  def index
    @users = policy_scope(User).sort_by(&:first_name)
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
