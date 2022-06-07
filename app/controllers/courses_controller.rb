class CoursesController < ApplicationController
  before_action :courses_params, only: %i[create]
  before_action :set_course, only: %i[show edit update destroy]
  before_action :set_active_courses

  def index
    @courses = policy_scope(Course).sort_by(&:created_at).reverse
  end

  def show
    authorize @course
  end

  def new
    @course = Course.new

    authorize @course
  end

  def create
    @course = Course.new(courses_params)
    @course.tutor_user_id = current_user.id
    @chatroom = Chatroom.create(name: "Assignment chat")

    authorize @course

    if @course.save
      UserMailer.with(
        user: @course.student,
        tutor: @course.tutor,
        course: @course.name,
        path: course_assignments_path(@course)
      ).invitation_email.deliver_now
      redirect_to courses_path
    else
      render :new
    end
  end

  def edit
    authorize @course
  end

  def update
    authorize @course

    if @course.update(courses_params)
      redirect_to courses_path
    else
      render :edit
    end
  end

  def destroy
    authorize @course
    @course.destroy

    redirect_to courses_path
  end

  private

  def courses_params
    params.require(:course).permit(:name, :description, :tutor_user_id, :student_user_id, :photo)
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def set_active_courses
    @active_courses = "class=active"
  end
end
