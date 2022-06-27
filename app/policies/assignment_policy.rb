class AssignmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "tutor"
        scope.select { |assignment| assignment.course.tutor == user }
      else
        scope.select { |assignment| assignment.course.student == user }
      end
    end
  end

  def show?
    record.course.tutor == user or record.course.student == user
  end

  def create?
    user.role == "tutor"
  end

  def new?
    create?
  end

  def update?
    record.course.tutor == user or record.course.student == user
  end

  def edit?
    update?
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
end
