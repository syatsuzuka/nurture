class AssignmentTemplatesController < ApplicationController
  before_action :assignment_templates_params, only: %i[create update]
  before_action :set_assignment_template, only: %i[show edit update destroy]
  before_action :set_assignment_templates_set, only: %i[index show new create edit update destroy upload import export]

  def index
    @assignment_templates = policy_scope(AssignmentTemplate).select do |assignment_template|
      assignment_template.assignment_templates_set == @assignment_templates_set
    end
  end

  def new
    @assignment_template = AssignmentTemplate.new
    authorize @assignment_template
  end

  def create
    @assignment_template = AssignmentTemplate.new(assignment_templates_params)
    @assignment_template.assignment_templates_set = @assignment_templates_set
    authorize @assignment_template

    if @assignment_template.save
      redirect_to assignment_templates_set_assignment_templates_path(@assignment_templates_set)
    else
      render :new
    end
  end

  def edit
    @assignment_template.assignment_templates_set = @assignment_templates_set
    authorize @assignment_template
  end

  def update
    @assignment_template.assignment_templates_set = @assignment_templates_set
    authorize @assignment_template

    if @assignment_template.update(assignment_templates_params)
      redirect_to assignment_templates_set_assignment_templates_path(@assignment_templates_set)
    else
      render :edit
    end
  end

  def destroy
    authorize @assignment_template
    @assignment_template.destroy

    redirect_to assignment_templates_set_assignment_templates_path(@assignment_templates_set)
  end

  def upload
    nil
  end

  def import
    AssignmentTemplate.import(params[:file], @assignment_templates_set)

    redirect_to assignment_templates_set_assignment_templates_path(@assignment_templates_set)
  end

  def export
    @assignment_templates = policy_scope(AssignmentTemplate).select do |assignment_template|
      assignment_template.assignment_templates_set == @assignment_templates_set
    end
    @assignment_templates.sort_by!(&:title)

    authorize Assignment

    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachments; filename=nurture_homework_templates.csv"
        render "export.csv.erb"
      end
    end
  end

  private

  def assignment_templates_params
    params.require(:assignment_template).permit(
      :title,
      :instruction,
      :instruction_url,
      :checkpoint,
      :assignment_templates_set
    )
  end

  def set_assignment_templates_set
    @assignment_templates_set = AssignmentTemplatesSet.find(params[:assignment_templates_set_id])
  end

  def set_assignment_template
    @assignment_template = AssignmentTemplate.find(params[:id])
  end
end
