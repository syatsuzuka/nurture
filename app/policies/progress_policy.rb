class ProgressPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "tutor"
        progresses = scope.select do |progress|
          progress.target.course.tutor == user || manager?(user, progress.target.course.tutor)
        end
      else
        progresses = scope.select { |progress| progress.target.course.student == user }
      end

      return Progress.where(id: progresses.map(&:id))
    end
  end

  def create?
    record.target.course.tutor == user \
      || record.target.course.student == user \
      || manager?(user, record.target.course.tutor)
  end

  def new?
    create?
  end

  def update?
    record.target.course.tutor == user \
      || record.target.course.student == user \
      || manager?(user, record.target.course.tutor)
  end

  def edit?
    update?
  end

  def export?
    record.target.course.tutor == user \
      || record.target.course.student == user \
      || manager?(user, record.target.course.tutor)
  end

  def destroy?
    record.target.course.tutor == user \
      || record.target.course.student == user \
      || manager?(user, record.target.course.tutor)
  end
end
