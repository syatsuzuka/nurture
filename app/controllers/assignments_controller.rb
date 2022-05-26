class AssignmentsController < ApplicationController
  before_action :assignment_params, only: %i[create update]
  before_action :set_course, only: %i[index new create edit update destroy close]
  before_action :set_assignment, only: %i[show edit update destroy close]

  def index
    all_assignments = policy_scope(Assignment).select { |assignment| assignment.course.id == @course.id }
    all_assignments.sort_by(&:created_at).reverse
    if current_user.role == "tutor"
      @assignments = all_assignments.select { |assignment| assignment.course.tutor_user_id == current_user.id }
    else
      @assignments = all_assignments.select { |assignment| assignment.course.student_user_id == current_user.id }
    end

    all_targets = policy_scope(Target).select { |target| target.course.id == @course.id }

    if current_user.role == "tutor"
      @targets = all_targets.select { |target| target.course.tutor_user_id == current_user.id }
    else
      @targets = all_targets.select { |target| target.course.student_user_id == current_user.id }
    end

    @chatroom = Chatroom.find(params[:course_id])
    authorize @chatroom
    @message = Message.new

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
    if @assignment.save!
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

    if @assignment.update!(assignment_params)
      redirect_to course_assignments_path(@course)
    else
      render :edit
    end
  end

  def destroy
    authorize @assignment
    @assignment.destroy!

    redirect_to course_assignments_path(@course)
  end

  def all
    if current_user.role == "tutor"
      @assignments = policy_scope(Assignment).select { |assignment| assignment.course.tutor_user_id == current_user.id }
    else
      @assignments = policy_scope(Assignment).select do |assignment|
        assignment.course.student_user_id == current_user.id
      end
    end
  end

  def close
    @assignment.course = @course
    @assignment.status = 2
    authorize @assignment

    if @assignment.save!
      redirect_to course_assignments_path(@course)
    else
      render course_assignments_path(@course)
    end
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
end
