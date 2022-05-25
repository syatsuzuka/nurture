class AssignmentsController < ApplicationController
  before_action :assignment_params, only: %i[create update]
  before_action :set_course, only: %i[index new create edit update close]
  before_action :set_assignment, only: %i[show edit update close]

  def index
    all_assignments = policy_scope(Assignment).select { |assignment| assignment.course.id == @course.id }

    if current_user.role == "tutor"
      @assignments = all_assignments.select { |assignment| assignment.course.tutor_user_id == current_user.id }
    else
      @assignments = all_assignments.select { |assignment| assignment.course.student_user_id == current_user.id }
    end
  end

  def show
    authorize @assignment
  end

  def new
    @assignment = Assignment.new
    @assignment.course = @course
    authorize @assignment
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.course = @course
    authorize @assignment
    if @assignment.save
      redirect_to course_assignment_path(@course, @assignment)
    else
      render :new
    end
  end

  def edit
    @assignment.course = @course
    authorize @assignment
  end

  def update
    @assignment.course = @course
    authorize @assignment

    if @assignment.update(assignment_params)
      redirect_to course_assignments_path(@course)
    else
      render :edit
    end
  end

  def close
    @assignment.course = @course
    authorize @assignment

    if @assignment.save!
      redirect_to course_assignments_path(@course)
    else
      render course_assignments_path(@course)
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :instruction, :comment, :checkpoint, :status, :course_id)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end
end
