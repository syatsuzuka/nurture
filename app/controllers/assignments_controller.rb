class AssignmentsController < ApplicationController
  before_action :assignment_params, only: %i[create update]
  before_action :set_course, only: %i[index new create edit update]
  before_action :set_assignment, only: %i[show edit update]

  def index
    @assignments = policy_scope(Assignment).select { |assignment| assignment.course.tutor_user_id == current_user.id }
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
  end

  def update
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
