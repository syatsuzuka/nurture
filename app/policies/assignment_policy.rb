class AssignmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "tutor"
        scope.select do |assignment|
          result = false
          result = true if assignment.course.tutor == user
          manager = assignment.course.tutor

          until manager.manager.nil?
            result = true if manager.manager == user
            manager = manager.manager
          end

          sample_student = User.find_by(email: ENV['SAMPLE_STUDENT_LOGIN_ID'])
          result = false if assignment.course.tutor != user && assignment.course.student == sample_student
          result
        end
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
