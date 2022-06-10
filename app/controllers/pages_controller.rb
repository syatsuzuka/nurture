class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]
  before_action :set_active_dashboard, only: %i[dashboard]
  before_action :set_active_aboutus, only: %i[aboutus]

  def home
    if user_signed_in?
      redirect_to dashboard_path
    else
      render layout: 'landing'
    end
  end

  def dashboard
    @courses =
      if params[:q].present?
        policy_scope(Course).search_by_name_and_description(params[:q])
      else
        policy_scope(Course)
      end

    authorize @courses

    if current_user.role == "tutor"
      assignments = policy_scope(Assignment).select { |assignment| assignment.course.tutor_user_id == current_user.id }
    else
      assignments = policy_scope(Assignment).select do |assignment|
        assignment.course.student_user_id == current_user.id
      end
    end

    # collecting done status assignments for toast
    @assignments = assignments.select do |assignment|
      assignment.status == 1
    end

    # authorize @assignments unless @assignments.nil?

    #======= Data Setup for graph =======
    @data = []
    @data_test = []

    @courses.each do |course|
      data_hash = []
      disp_targets = course.targets.select { |target| target.display == true }
      disp_targets.each do |target|
        progresses = Progress.where(target: target).order(date: :asc)
        data = progresses.map do |progress|
          [progress.date.strftime("%F"), progress.score]
        end
        data_hash << { name: target.name, data: data }
      end
      @data << data_hash
    end
    # gon.data_test = [12, 5, 3, 5, 2, 3]
  end

  def aboutus
  end

  private

  def set_active_dashboard
    @active_dashboard = "class=active"
  end

  def set_active_aboutus
    @active_aboutus = "class=active"
  end
end
