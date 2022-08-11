class TargetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "tutor"
        targets = scope.select do |target|
          target.course.tutor == user || manager?(user, target.course.tutor)
        end
      else
        targets = scope.select { |target| target.course.student == user }
      end

      return Target.where(id: targets.map(&:id)).order(:name)
    end
  end

  def create?
    record.course.tutor == user || manager?(user, record.course.tutor)
  end

  def new?
    create?
  end

  def update?
    record.course.tutor == user || manager?(user, record.course.tutor)
  end

  def edit?
    update?
  end

  def destroy?
    record.course.tutor == user || manager?(user, record.course.tutor)
  end
end
