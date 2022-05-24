class AssignmentsController < ApplicationController
  before_action :set_assignment, only: %i[edit]

  def index
    @assignments = Assignment.all
  end

  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      redirect_to assignment_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :instruction, :comment, :checkpoint, :status, :course_id)
  end
  
  def set_assignment
    @assignment = Assignment.find(params[:id])
  end
end
