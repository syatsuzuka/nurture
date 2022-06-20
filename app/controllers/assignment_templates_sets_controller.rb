class AssignmentTemplatesSetsController < ApplicationController
  before_action :assignment_templates_sets_params, only: %i[create update]
  before_action :set_assignment_templates_set, only: %i[show edit update destroy]

  def new
    @assignment_templates_set = AssignmentTemplatesSet.new
    @assignment_templates_set.user = current_user
    authorize @assignment_templates_set
  end

  def create
    @assignment_templates_set = AssignmentTemplatesSet.new(assignment_templates_sets_params)
    @assignment_templates_set.user = current_user
    authorize @assignment_templates_set

    if @assignment_templates_set.save
      redirect_to template_path
    else
      render :new
    end
  end

  private

  def assignment_templates_sets_params
    params.require(:assignment_templates_set).permit(:name, :category, :visible, :user_id)
  end

  def set_assignment_templates_set
    @assignment_templates_set = AssignmentTemplatesSet.find(params[:id])
  end
end
