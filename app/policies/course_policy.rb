class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "tutor"
        scope.select do |course|
          result = false
          result = true if course.tutor == user
          manager = course.tutor

          until manager.manager.nil?
            result = true if manager.manager == user
            manager = manager.manager
          end

          if course.tutor != user && course.student == User.find_by(email: ENV['SAMPLE_STUDENT_LOGIN_ID'])
            result = false
          end
          result
        end.sort_by!(&:name)
      else
        scope.where(student_user_id: user.id)
      end
    end
  end

  def index?
    record.tutor == user or record.student == user # when accept the course
  end

  def create?
    user.role == "tutor"
  end

  def new?
    create?
  end

  def update?
    record.tutor == user or record.student == user # when accept the course
  end

  def edit?
    update?
  end

  def destroy?
    record.tutor == user
  end

  def accept?
    record.student == user
  end

  def dashboard?
    record.tutor == user or record.student == user
  end

  def import?
    record.tutor == user or record.student == user
  end

  def upload?
    import?
  end

  def review?
    record.tutor == user
  end

  def close?
    record.tutor == user
  end

  def export?
    record.tutor == user or record.student == user
  end
end
