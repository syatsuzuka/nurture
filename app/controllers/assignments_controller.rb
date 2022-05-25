class AssignmentsController < ApplicationController
  before_action :set_assignment, only: %i[edit show]
  before_action :set_course, only: %i[index new]

  def index
    @assignments = policy_scope(Assignment).order(created_at: :desc)
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
    if @assignment.save
      redirect_to assignments_path
    else
      render :new
    end
  end


  def edit
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end
end
