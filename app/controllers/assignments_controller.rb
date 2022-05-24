class AssignmentsController < ApplicationController
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

  def assignment_params
    params.require(:assignment).permit(:title, :instruction, :comment, :checkpoint, :status, :course_id)
  end
end
