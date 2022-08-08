class AssignmentsController < ApplicationController
  before_action :assignment_params, only: %i[create update]
  before_action :set_course, only: %i[
    index new create edit update destroy review close done upload import export
  ]
  before_action :set_assignment, only: %i[show edit update destroy review close]
  before_action :set_active_assignments, only: %i[all]
  before_action :set_active_courses, only: %i[index show new create edit update destroy review close]

  def index
    @assignments =  policy_scope(Assignment)
                    .select { |assignment| assignment.course.id == @course.id }
                    .sort_by(&:created_at)
    @targets =  policy_scope(Target)
                .select { |target| target.course.id == @course.id }
                .sort_by do |target|
      element = target
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
        target.name
      else
        "#{parentpath}> #{target.name}"
      end
    end

    #======= Data setting for Graph (target) =======
    @data_hash = []
    display_targets = @targets.select { |target| target.display == true }
    display_targets.each do |target|
      progresses = Progress.where(target: target)
      data = progresses.map do |progress|
        [progress.date.strftime("%F"), progress.score]
      end
      @data_hash << { name: target.name, data: data }
    end

    #======= Data setting for Target Tree =======
    gon.tree_data = []
    gon.tree_height = 400

    @targets.each do |target|
      if target.parent.nil?
        gon.tree_data << ["Goal", target.name]
      else
        gon.tree_data << [target.parent.name, target.name]
      end
    end
    gon.tree_title = t('.text_tree_title')

    #======= Data Setup for Gannt Chart =======
    gon.courses = []
    gon.courses[0] = []
    @open_assignments = @assignments.select { |assignment| assignment.status.zero? && assignment.course == @course }

    @open_assignments.each do |assignment|
      if current_user.role == "tutor"
        user_name = assignment.course.student.first_name
      else
        user_name = assignment.course.tutor.first_name
      end

      start_date = assignment.start_date.nil? ? assignment.created_at.to_date : assignment.start_date
      end_date = assignment.end_date.nil? ? Date.today + 7 : assignment.end_date

      gon.courses[0] << {
        "name" => t('.text_gannt_title'),
        "user_name" => user_name,
        "homework" => {
          "title" => assignment.title,
          "start_date" => (start_date - Date.today).to_i,
          "end_date" => (end_date - Date.today).to_i
        }
      }
    end

    #======= Chatroom =======
    @chatroom = Chatroom.find(params[:course_id])
    authorize @chatroom
    @message = Message.new
    messages = @chatroom.messages
    new_messages = messages.where.not(user_id: current_user[:id]).where(read: nil)
    unless new_messages.empty?
      new_messages.each do |message|
        message.update_attribute(:read, DateTime.now)
      end
      # flash[:alert] = "Hello #{current_user.first_name} you have new messages in chat!"
    end
    #=========================
  end

  def show
    authorize @assignment
  end

  def new
    @assignment = Assignment.new
    @assignment.course = @course

    authorize @assignment
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.course = @course
    @assignment.status = 0
    authorize @assignment
    if @assignment.save
      redirect_to course_assignments_path(@course)
    else
      render :new
    end
  end

  def edit
    @assignment.course = @course
    authorize @assignment
  end

  def update
    @assignment.course = @course
    authorize @assignment

    if @assignment.update(assignment_params)
      redirect_to course_assignments_path(@course)
    else
      render :edit
    end
  end

  def destroy
    authorize @assignment
    @assignment.destroy

    redirect_to course_assignments_path(@assignment.course)
  end

  def all
    @assignments = policy_scope(Assignment).reject do |assignment|
      sample_course?(current_user, assignment)
    end
    @assignments.sort_by!(&:status)
  end

  def review
    @assignment.course = @course
    authorize @assignment
  end

  def close
    @assignment.course = @course
    @assignment.status = 2
    authorize @assignment

    @assignment.save
    redirect_to course_assignments_path(@course)
  end

  def upload
    nil
  end

  def import
    Assignment.import(params[:file], @course)

    redirect_to course_assignments_path(@course)
  end

  def export
    @assignments = policy_scope(Assignment).select { |assignment| assignment.course == @course }
    @assignments.sort_by!(&:title)

    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachments; filename=nurture_homework.csv"
      end
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(
      :title,
      :instruction,
      :instruction_url,
      :comment,
      :material_url,
      :checkpoint,
      :status,
      :review_comment,
      :start_date,
      :end_date,
      :course_id,
      :instruction_video,
      :material_video,
      :target_id
    )
  end

  def set_course
    @course = Course.find(params[:course_id])
    authorize @course
  end

  def set_assignment
    @assignment = Assignment.find(params[:id])
    authorize @assignment
  end

  def set_active_assignments
    @active_assignments = "class=active"
  end

  def set_active_courses
    @active_courses = "class=active"
  end
end
