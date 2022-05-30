class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :set_active_dashboard, only: %i[dashboard]
  before_action :set_active_aboutus, only: %i[aboutus]

  def home
    render layout: 'landing'
  end

  def dashboard
    @courses = policy_scope(Course)
    authorize @courses

    if current_user.role == "tutor"
      assignments = policy_scope(Assignment).select { |assignment| assignment.course.tutor_user_id == current_user.id }
    else
      assignments = policy_scope(Assignment).select do |assignment|
        assignment.course.student_user_id == current_user.id
      end
    end

    @assignments = assignments.select do |assignment|
      assignment.status == 1
    end

    # authorize @assignments unless @assignments.nil?

    #======= Data Setup for graph =======
    @data = []
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
