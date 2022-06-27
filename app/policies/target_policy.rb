class TargetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "tutor"
        scope.select { |target| target.course.tutor == user }
      else
        scope.select { |target| target.course.student == user }
      end
    end
  end

  def create?
    user.role == "tutor"
  end

  def new?
    create?
  end

  def update?
    user.role == "tutor"
  end

  def edit?
    update?
  end

  def destroy?
    true
  end
end
