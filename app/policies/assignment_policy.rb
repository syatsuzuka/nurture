class AssignmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "tutor"
        scope.all.select { |assignment| assignment.course.tutor == user }
      else
        scope.select { |assignment| assignment.course.student == user }
      end
    end
  end

  def show?
    record.course.tutor == user or record.course.student == user
  end

  def new?
    user.role == "tutor"
  end

  def create?
    user.role == "tutor"
  end

  def edit?
    record.course.tutor == user or record.course.student == user
  end

  def update?
    record.course.tutor == user or record.course.student == user
  end

  def destroy?
    record.course.tutor == user
  end

  def review?
    record.course.tutor == user
  end

  def close?
    record.course.tutor == user
  end

  def export?
    record.course.tutor == user or record.course.student == user
  end
end
