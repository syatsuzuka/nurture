class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

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
      course.targets.each do |target|
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
end
