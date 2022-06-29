class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_review, only: [:show]
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
    if current_user.role == "tutor"
      @reviews = @user.student_reviews
      @review_flag = @reviews.select { |review| review.tutor == current_user }.any?
    else
      @reviews = @user.tutor_reviews
      @review_flag = @reviews.select { |review| review.student == current_user }.any?
    end

    #======= Calculate average score =======
    sum_star = 0
    @reviews.each do |review|
      sum_star += review.stars
    end
    @average_star = sum_star.fdiv(@reviews.count)

    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_review
    @review = Review.find_by(tutor: @user, student: current_user)
  end

  def set_active_users
    @active_users = "class=active"
  end

  def set_manager_options
    if @manager.nil?
      manager_options = User.where(role: "tutor").order(:name)
    else
      manager_options = User.where(role: "tutor").where.not(id: @user.id).order(:name)
    end

    @manager_options = manager_options.select do |manager|
      result = true
      until manager.parent.nil?
        result = false if manager.parent == @user
        manager = manager.parent
      end
      result
    end
  end
end
