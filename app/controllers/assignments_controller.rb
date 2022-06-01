class AssignmentsController < ApplicationController
  before_action :assignment_params, only: %i[create update]
  before_action :set_course, only: %i[index new create edit update destroy close close2 done]
  before_action :set_assignment, only: %i[show edit update destroy close close2 done]
  before_action :set_active_assignments, only: %i[all]
  before_action :set_active_courses, only: %i[index show new create edit update destroy close close2 done]

  def index
    all_assignments = policy_scope(Assignment).select { |assignment| assignment.course.id == @course.id }
    all_assignments.sort_by(&:created_at).reverse
    all_targets = policy_scope(Target).select { |target| target.course.id == @course.id }

    if current_user.role == "tutor"
      @assignments = all_assignments.select { |assignment| assignment.course.tutor_user_id == current_user.id }
      @targets = all_targets.select { |target| target.course.tutor_user_id == current_user.id }
    else
      @assignments = all_assignments.select { |assignment| assignment.course.student_user_id == current_user.id }
      @targets = all_targets.select { |target| target.course.student_user_id == current_user.id }
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

    #======= Data Setup for graph (assignment) =======
    num_days = 100
    end_date = Date.today
    start_date = end_date - num_days

    @data_assignment = []
    data = []
    @data_flag = false

    (start_date..end_date).each do |date|
      open_assignments = @assignments.select do |assignment|
        @data_flag = true
        if [0, 1].include? assignment.status
          assignment.start_date <= date and assignment.end_date >= date unless assignment.end_date.nil?
        end
      end
      count = open_assignments.count
      data << [date.strftime("%F"), count]
    end

    @data_assignment << { name: "assignment", data: data }

    #======= Chatroom =======
    @chatroom = Chatroom.find(params[:course_id])
    authorize @chatroom
    @message = Message.new
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
      redirect_to all_assignments_path
    else
      render :edit
    end
  end

  def destroy
    authorize @assignment
    @assignment.destroy

    redirect_to all_assignments_path
  end

  def all
    if current_user.role == "tutor"
      @assignments = policy_scope(Assignment).select { |assignment| assignment.course.tutor_user_id == current_user.id }
    else
      @assignments = policy_scope(Assignment).select do |assignment|
        assignment.course.student_user_id == current_user.id
      end
    end
    @assignments.sort_by!(&:status)
  end

  def close
    @assignment.course = @course
    @assignment.status = 2
    authorize @assignment

    @assignment.save
    redirect_to course_assignments_path(@course)
  end

  def close2
    @assignment.course = @course
    @assignment.status = 2
    authorize @assignment

    @assignment.save
    redirect_to all_assignments_path
  end

  def done
    @assignment.course = @course
    @assignment.status = 1
    authorize @assignment

    @assignment.save
    redirect_to all_assignments_path
  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :instruction, :comment, :checkpoint, :status, :start_date, :end_date, :course_id)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def set_active_assignments
    @active_assignments = "class=active"
  end

  def set_active_courses
    @active_courses = "class=active"
  end
end
