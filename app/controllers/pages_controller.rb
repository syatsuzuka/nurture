class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]
  before_action :set_active_dashboard, only: %i[dashboard]
  before_action :set_active_knowledge, only: %i[knowledge]
  before_action :set_active_aboutus, only: %i[aboutus]

  def home
    if user_signed_in?
      redirect_to dashboard_path
    else
      render layout: 'landing'
    end
  end

  def dashboard
    #======= PGsearch =======
    @courses =
      if params[:q].present?
        policy_scope(Course).search_by_name_and_description(params[:q])
      else
        policy_scope(Course)
      end

    authorize @courses

    #======= Collecting done status assignments for toast =======
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

    #======= Data Setup for Line Chart =======
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

    #======= Data Setup for Gannt Chart =======
    gon.courses = []
    @open_assignments = assignments.select { |assignment| assignment.status.zero? }
    @open_assignments.each do |assignment|
      if current_user.role == "tutor"
        user_name = assignment.course.student.first_name
      else
        user_name = assignment.course.tutor.first_name
      end

      start_date = assignment.start_date.nil? ? assignment.created_at.to_date : assignment.start_date
      end_date = assignment.end_date.nil? ? Date.today + 7 : assignment.end_date

      gon.courses << {
        "name" => assignment.course.name,
        "user_name" => user_name,
        "homework" => {
          "title" => assignment.title,
          "start_date" => (start_date - Date.today).to_i,
          "end_date" => (end_date - Date.today).to_i
        }
      }
    end
  end

  def knowledge
  end

  def aboutus
  end

  private

  def set_active_dashboard
    @active_dashboard = "class=active"
  end

  def set_active_knowledge
    @active_knowledge = "class=active"
  end

  def set_active_aboutus
    @active_aboutus = "class=active"
  end
end
