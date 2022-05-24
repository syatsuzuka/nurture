class AssignmentsController < ApplicationController
  before_action :set_assignment, only: %i[edit]

  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  private

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end
end
