class TargetTemplatesController < ApplicationController
  before_action :target_templates_params, only: %i[create update]
  before_action :set_target_template, only: %i[show edit update destroy]
  before_action :set_target_templates_set, only: %i[index show new create edit update destroy upload import export]
  before_action :set_target_template_options, only: %i[new edit]

  def index
    all_target_templates = policy_scope(TargetTemplate).select do |target_template|
      target_template.target_templates_set == @target_templates_set
    end

    @target_templates = all_target_templates.sort_by do |target_template|
      element = target_template
      parentpath = ""

      until element.parent.nil?
        element = element.parent
        if element.parent.nil?
          parentpath = "#{element.name} #{parentpath}"
        else
          parentpath = "> #{element.name} #{parentpath}"
        end
      end

      if parentpath.blank?
        target_template.name
      else
        "#{parentpath}> #{target_template.name}"
      end
    end
  end

  def new
    @target_template = TargetTemplate.new
    authorize @target_template
  end

  def create
    @target_template = TargetTemplate.new(target_templates_params)
    @target_template.target_templates_set = @target_templates_set
    authorize @target_template

    if @target_template.save
      redirect_to target_templates_set_target_templates_path(@target_templates_set)
    else
      render :new
    end
  end

  def edit
    @target_template.target_templates_set = @target_templates_set
    authorize @target_template
  end

  def update
    @target_template.target_templates_set = @target_templates_set
    authorize @target_template

    if @target_template.update(target_templates_params)
      redirect_to target_templates_set_target_templates_path(@target_templates_set)
    else
      render :edit
    end
  end

  def destroy
    authorize @target_template
    @target_template.destroy

    redirect_to target_templates_set_target_templates_path(@target_templates_set)
  end

  def upload
    nil
  end

  def import
    TargetTemplate.import(params[:file], @target_templates_set)

    redirect_to target_templates_set_target_templates_path(@target_templates_set)
  end

  def export
    @target_templates = policy_scope(TargetTemplate).select do |target_template|
      target_template.target_templates_set == @target_templates_set
    end
    @target_templates.sort_by!(&:name)

    authorize Target

    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachments; filename=nurture_target_templates.csv"
        render "export.csv.erb"
      end
    end
  end

  private

  def target_templates_params
    params.require(:target_template).permit(:name, :parent_id, :description, :score, :target_templates_set)
  end

  def set_target_templates_set
    @target_templates_set = TargetTemplatesSet.find(params[:target_templates_set_id])
  end

  def set_target_template
    @target_template = TargetTemplate.find(params[:id])
  end

  def set_target_template_options
    if @target_template.nil?
      target_template_options = TargetTemplate.where(target_templates_set: @target_templates_set).order(:name)
    else
      target_template_options = TargetTemplate.where(target_templates_set: @target_templates_set).where.not(id: @target_template.id).order(:name)
    end

    @target_template_options = target_template_options.select do |target_template|
      result = true
      until target_template.parent.nil?
        result = false if target_template.parent == @target_template
        target_template = target_template.parent
      end
      result
    end
  end
end
