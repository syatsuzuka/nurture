class ProgressPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "tutor"
        scope.select { |progress| progress.target.course.tutor == user }
      else
        scope.select { |progress| progress.target.course.student == user }
      end
    end
  end

  def create?
    user.role == "tutor" or user.role == "student"
  end

  def new?
    create?
  end

  def update?
    record.target.course.tutor == user or record.target.course.student == user
  end

  def edit?
    update?
  end

  def destroy?
    record.target.course.tutor == user or record.target.course.student == user
  end
end
