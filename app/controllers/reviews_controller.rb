class ReviewsController < ApplicationController
  before_action :set_tutor, only: %i[new create edit update destroy]
  before_action :set_review, only: %i[edit update destroy]
  before_action :set_active_users

  def new
    @review = Review.new
    @review.tutor = @tutor
    authorize @review
  end

  def create
    @review = Review.new(reviews_params)
    @review.tutor = @tutor
    @review.student = current_user
    authorize @review

    if @review.save
      redirect_to tutor_path(@tutor)
    else
      render :new
    end
  end

  def edit
    @review.tutor = @tutor
    authorize @review
  end

  def update
    @review.tutor = @tutor
    authorize @review

    if @review.update(reviews_params)
      redirect_to tutor_path(@tutor)
    else
      render :edit
    end
  end

  def destroy
    authorize @review
    @review.destroy

    redirect_to tutor_path(@tutor)
  end

  private

  def reviews_params
    params.require(:review).permit(:stars, :comment, :anonymous, :tutor_id, :student_id)
  end

  def set_tutor
    @tutor = User.find(params[:tutor_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def set_active_users
    @active_users = "class=active"
  end
end
