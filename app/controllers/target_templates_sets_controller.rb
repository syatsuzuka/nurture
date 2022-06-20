class TargetTemplatesSetsController < ApplicationController
  before_action :target_templates_sets_params, only: %i[create update]
  before_action :set_target_templates_set, only: %i[show edit update destroy]

  def new
    @target_templates_set = TargetTemplatesSet.new
    @target_templates_set.user = current_user
    authorize @target_templates_set
  end

  def create
    @target_templates_set = TargetTemplatesSet.new(target_templates_sets_params)
    @target_templates_set.user = current_user
    authorize @target_templates_set

    if @target_templates_set.save
      redirect_to template_path
    else
      render :new
    end
  end

  private

  def target_templates_sets_params
    params.require(:target_templates_set).permit(:name, :category, :visible, :user_id)
  end

  def set_target_templates_set
    @target_templates_set = TargetTemplatesSet.find(params[:id])
  end
end
