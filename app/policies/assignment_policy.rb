class AssignmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "tutor"
        assignments = scope.select do |assignment|
          result = false
          result = true if assignment.course.tutor == user
          result = true if manager?(user, assignment.course.tutor)

          result
        end
      else
        assignments = scope.select { |assignment| assignment.course.student == user }
      end

      return Assignment.where(id: assignments.map(&:id))
    end
  end

  def show?
    record.course.tutor == user \
    || record.course.student == user \
    || manager?(user, record.course.tutor)
  end

  def create?
    record.course.tutor == user || manager?(user, record.course.tutor)
  end

  def new?
    create?
  end

  def update?
    record.course.tutor == user \
    || record.course.student == user \
    || manager?(user, record.course.tutor)
  end

  def edit?
    update?
  end

  def destroy?
    record.course.tutor == user || manager?(user, record.course.tutor)
  end

  def review?
    record.course.tutor == user || manager?(user, record.course.tutor)
  end

  def close?
    record.course.tutor == user || manager?(user, record.course.tutor)
  end
end
