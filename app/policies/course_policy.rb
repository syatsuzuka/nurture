class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "tutor"
        scope.where(tutor_user_id: user.id)
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
    user.role == "tutor"
  end

  def update?
    record.tutor == user or record.student == user # when accept the course
  end

  def edit?
    record.tutor == user or record.student == user
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
    record.tutor == user or record.student == user
  end

  def review?
    record.tutor == user
  end

  def export?
    record.tutor == user or record.student == user
  end
end
