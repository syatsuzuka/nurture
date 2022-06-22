class TargetTemplatesController < ApplicationController
  before_action :target_templates_params, only: %i[create update]
  before_action :set_target_template, only: %i[show edit update destroy]
  before_action :set_target_templates_set, only: %i[index show new create edit update destroy]

  def index
    @target_templates = policy_scope(TargetTemplate)
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

  private

  def target_templates_params
    params.require(:target_template).permit(:name, :description, :score, :target_templates_set)
  end

  def set_target_templates_set
    @target_templates_set = TargetTemplatesSet.find(params[:target_templates_set_id])
  end

  def set_target_template
    @target_template = TargetTemplate.find(params[:id])
  end
end