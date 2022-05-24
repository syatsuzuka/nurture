class CoursesController < ApplicationController
  before_action :courses_params, only: %i[create]
  before_action :set_course, only: %i[show edit update]

  def index
    @courses = policy_scope(Course)
  end

  def show
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create
    @course = Course.new(courses_params)
    authorize @course

    if @course.save
      redirect_to courses_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(courses_params)
      redirect_to courses_path
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def courses_params
    params.require(:course).permit(:name, :description, :tutor_user_id, :student_user_id)
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
