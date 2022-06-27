require 'csv'

class ProgressesController < ApplicationController
  before_action :progress_params, only: %i[create update]
  before_action :set_course, only: %i[index new create edit update destroy upload import export]
  before_action :set_target, only: %i[index new create edit update destroy upload import export]
  before_action :set_progress, only: %i[show edit update destroy]
  before_action :set_active_courses

  def index
    all_progresses = policy_scope(Progress).select { |progress| progress.target.id == @target.id }
    all_progresses.sort_by!(&:date)

    if current_user.role == "tutor"
      @progresses = all_progresses.select { |progress| progress.target.course.tutor_user_id == current_user.id }
    else
      @progresses = all_progresses.select { |progress| progress.target.course.student_user_id == current_user.id }
    end

    #===== Data set for graph =====
    @data = []
    data_hash_progress = []
    data_hash_target = []

    @progresses.each do |progress|
      data_hash_progress << [progress.date.strftime("%F"), progress.score]
      data_hash_target << [progress.date.strftime("%F"), @target.score]
    end
    @data << { name: "target", data: data_hash_target }
    @data << { name: "progress", data: data_hash_progress }
  end

  def new
    @progress = Progress.new
    @progress.target = @target
    authorize @progress
  end

  def create
    @progress = Progress.new(progress_params)
    @progress.target = @target
    authorize @progress

    if @progress.save
      redirect_to course_target_progresses_path(@course, @target)
    else
      render :new
    end
  end

  def edit
    @progress.target = @target
    authorize @progress
  end

  def update
    @progress.target = @target
    authorize @progress

    if @progress.update(progress_params)
      redirect_to course_target_progresses_path(@course, @target)
    else
      render :edit
    end
  end

  def destroy
    authorize @progress
    @progress.destroy

    redirect_to course_target_progresses_path(@course, @target)
  end

  def upload
    nil
  end

  def import
    Progress.import(params[:file], @target)

    redirect_to course_target_progresses_path(@course, @target)
  end

  def export
    @progresses = policy_scope(Progress).select { |progress| progress.target == @target }
    @progresses.sort_by!(&:date)

    authorize Progress

    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachments; filename=nurture_progresses.csv"
        render "export.csv.erb"
      end
    end
  end

  private

  def progress_params
    params.require(:progress).permit(:date, :score, :comment, :target_id)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_target
    @target = Target.find(params[:target_id])
  end

  def set_progress
    @progress = Progress.find(params[:id])
  end

  def set_active_courses
    @active_courses = "class=active"
  end
end
