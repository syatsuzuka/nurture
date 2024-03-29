class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home docs company]
  before_action :set_active_dashboard, only: %i[dashboard]
  before_action :set_active_report, only: %i[report print_report]
  before_action :set_active_template, only: %i[template]
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
    courses =
      if params[:q].present?
        policy_scope(Course).search(params[:q])
      else
        policy_scope(Course)
      end

    @courses = courses.select do |course|
      course.status == 1
    end

    @waiting_courses = courses.select { |course| course.status.zero? }

    #======= Collecting done status assignments for toast =======
    assignments = policy_scope(Assignment)
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
    gon.assignments = []
    gon.gannt_title = t('.text_gannt_title')
    @open_assignments = assignments
                        .select { |assignment| assignment.status.zero? }
                        .sort_by { |v| [v.end_date ? 0 : 1, v.end_date] }

    @open_assignments.each do |assignment|
      if current_user.role == "tutor"
        user_name = assignment.course.student.first_name
        if current_user.users.any?
          title = "#{assignment.course.name} with #{assignment.course.tutor.first_name}"
        else
          title = assignment.course.name
        end
      else
        user_name = assignment.course.tutor.first_name
      end
      start_date = assignment.start_date.nil? ? assignment.created_at.to_date : assignment.start_date
      end_date = assignment.end_date.nil? ? Date.today + 7 : assignment.end_date

      gon.assignments << {
        "name" => title,
        "user_name" => user_name,
        "homework" => {
          "title" => assignment.title,
          "start_date" => (start_date - Date.today).to_i,
          "end_date" => (end_date - Date.today).to_i
        }
      }
    end

    #======= Data Setup for Gannt Chart =======

    gon.courses = []
    @gannt_chart_num = 0

    @courses.each_with_index do |course, index|
      gon.courses[index] = []
      open_assignments = assignments.select { |assignment| assignment.status.zero? && assignment.course == course }

      @gannt_chart_num += 1 if open_assignments.count.positive?

      open_assignments.each do |assignment|
        if current_user.role == "tutor"
          user_name = assignment.course.student.first_name
          if current_user.users.any?
            title = "#{assignment.course.name} with #{assignment.course.tutor.first_name}"
          else
            title = assignment.course.name
          end
        else
          title = assignment.course.name
          user_name = assignment.course.tutor.first_name
        end
        start_date = assignment.start_date.nil? ? assignment.created_at.to_date : assignment.start_date
        end_date = assignment.end_date.nil? ? Date.today + 7 : assignment.end_date

        gon.courses[index] << {
          "name" => "#{title} - #{user_name}",
          "user_name" => user_name,
          "homework" => {
            "title" => assignment.title,
            "start_date" => (start_date - Date.today).to_i,
            "end_date" => (end_date - Date.today).to_i
          }
        }
      end
    end

    #======= Data Setup for Target Tree =======
    gon.tree_data = []
    gon.tree_height = 600
    gon.tree_title = t('.text_tree_title')

    @courses.each do |course|
      next if sample_course?(current_user, course)

      if current_user.role == "tutor"
        gon.tree_data << ['Goal', "Success of #{get_fullname(course.student)}"]
        gon.tree_data << [
          "Success of #{get_fullname(course.student)}",
          "#{course.name} with #{course.tutor.first_name} <#{course.student.nickname}>"
        ]
      else
        gon.tree_data << [
          "Goal",
          "#{course.name} with #{course.tutor.first_name} <#{course.student.nickname}>"
        ]
      end

      course.targets.each do |target|
        if target.parent.nil?
          gon.tree_data << [
            "#{course.name} with #{course.tutor.first_name} <#{course.student.nickname}>",
            "#{target.name} <#{course.name}, #{course.student.nickname}>"
          ]
        else
          gon.tree_data << [
            "#{target.parent.name} <#{course.name}, #{course.student.nickname}>",
            "#{target.name} <#{course.name}, #{course.student.nickname}>"
          ]
        end
      end
    end
    @tree_data = gon.tree_data

    #======= Data Setup for Org Chart =======
    gon.org_nodes = []
    gon.org_data = []
    gon.org_title = t('.text_org_title')

    #----- Add Current User -----
    org_node = {
      id: current_user.nickname,
      title: "",
      color: '#980104',
      name: "#{current_user.first_name.capitalize} #{current_user.last_name.capitalize}"
    }
    gon.org_nodes << org_node

    if current_user.role == "tutor"
      #----- Add Each Tutors / Students in courses -----
      @courses.each do |course|
        #----- Skip Sample Student -----
        next if sample_course?(current_user, course)

        #----- Add Student -----
        org_node = {
          id: course.student.nickname,
          title: "student",
          color: '#359154',
          name: "#{course.student.first_name.capitalize} #{course.student.last_name.capitalize}"
        }
        gon.org_nodes << org_node

        #----- Add Tutor -----
        if course.tutor != current_user
          org_node = {
            id: course.tutor.nickname,
            title: "tutor",
            name: "#{course.tutor.first_name.capitalize} #{course.tutor.last_name.capitalize}"
          }
          gon.org_nodes << org_node
        end

        org_data = [course.tutor.nickname, course.student.nickname]
        gon.org_data << org_data

        #----- Add Manager -----
        tutor = course.tutor
        until tutor.manager.nil?
          org_node = {
            id: tutor.manager.nickname,
            title: "manager",
            name: "#{tutor.manager.first_name.capitalize} #{tutor.manager.last_name.capitalize}"
          }
          gon.org_nodes << org_node

          org_data = [tutor.manager.nickname, tutor.nickname]
          gon.org_data << org_data

          tutor = tutor.manager
        end
      end
    else
      #----- Add Tutor / Student -----
      @courses.each do |course|
        #----- Skip Sample Tutor -----
        next if sample_course?(current_user, course)

        #----- Add Tutor -----
        org_node = {
          id: course.tutor.nickname,
          title: "tutor",
          name: "#{course.tutor.first_name.capitalize} #{course.tutor.last_name.capitalize}"
        }
        gon.org_nodes << org_node

        org_data = [course.tutor.nickname, course.student.nickname]
        gon.org_data << org_data

        #----- Add Manager -----
        tutor = course.tutor
        until tutor.manager.nil?
          org_node = {
            id: tutor.manager.nickname,
            title: "manager",
            name: "#{tutor.manager.first_name.capitalize} #{tutor.manager.last_name.capitalize}"
          }
          gon.org_nodes << org_node

          org_data = [tutor.manager.nickname, tutor.nickname]
          gon.org_data << org_data

          tutor = tutor.manager
        end
      end
    end
    gon.org_nodes.uniq!
    gon.org_data.uniq!
    @org_data = gon.org_data
  end

  def report
    if params[:q].present?
      targets = policy_scope(Target).search(params[:q])
    else
      targets = policy_scope(Target)
    end

    @targets = targets.reject do |target|
      sample_course?(current_user, target.course)
    end

    @pagy, @targets_pagy = pagy(
      Target.where(id: @targets.map(&:id))
        .includes(:course)
        .order("courses.name")
        .order("courses.student_user_id")
        .order(:name)
    )
  end

  def print_report
    @courses = policy_scope(Course).reject do |course|
      sample_course?(current_user, course)
    end
    @courses.sort_by! { |course| [course.name, course.student_user_id] }
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf: "progress_report.pdf",
                template: '/pages/print_report.html',
                header: {
                  html: {
                    template: 'layouts/pdf_header'
                  }
                }
      end
    end
  end

  def template
    if params[:q].present?
      @target_templates_sets = policy_scope(TargetTemplatesSet).search(params[:q])
      @assignment_templates_sets = policy_scope(AssignmentTemplatesSet).search(params[:q])
    else
      @target_templates_sets = policy_scope(TargetTemplatesSet)
      @assignment_templates_sets = policy_scope(AssignmentTemplatesSet)
    end
  end

  def knowledge
    @target_templates_sets = policy_scope(TargetTemplatesSet)
    @assignment_templates_sets = policy_scope(AssignmentTemplatesSet)

    if params[:q].present?
      posts = policy_scope(Post).search(params[:q])
    else
      posts = policy_scope(Post)
    end

    @pagy, @posts = pagy(posts.order(created_at: :desc))
  end

  def docs
    if user_signed_in?
      render layout: 'application'
    else
      render layout: 'public'
    end
  end

  def company
    if user_signed_in?
      render layout: 'application'
    else
      render layout: 'public'
    end
  end

  def aboutus
  end

  private

  def set_active_dashboard
    @active_dashboard = "class=active"
  end

  def set_active_report
    @active_report = "class=active"
  end

  def set_active_template
    @active_template = "class=active"
  end

  def set_active_knowledge
    @active_knowledge = "class=active"
  end

  def set_active_aboutus
    @active_aboutus = "class=active"
  end
end
