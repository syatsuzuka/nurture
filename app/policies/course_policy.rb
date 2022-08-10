class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "tutor"
        courses = scope.select do |course|
          course.tutor == user || (manager?(user, course.tutor) && !sample_course?(user, course))
        end
        return Course.where(id: courses.map(&:id)).order(:created_at)
      else
        scope.where(student_user_id: user.id).order(:created_at)
      end
    end
  end

  def index?
    record.tutor == user \
      || record.student == user \
      || manager?(user, record.tutor)
  end

  def create?
    user.role == "tutor" || record.student == user # accept course by student
  end

  def new?
    create?
  end

  def update?
    record.tutor == user \
      || record.student == user \
      || manager?(user, record.tutor)
  end

  def edit?
    update?
  end

  def destroy?
    record.tutor == user \
    || manager?(user, record.tutor)
  end

  def accept?
    record.student == user
  end

  def import?
    record.tutor == user \
    || record.student == user \
    || manager?(user, record.tutor)
  end

  def upload?
    import?
  end

  def review?
    record.tutor == user \
    || manager?(user, record.tutor)
  end

  def close?
    record.tutor == user \
    || manager?(user, record.tutor)
  end

  def export?
    record.tutor == user \
    || record.student == user \
    || manager?(user, record.tutor)
  end
end
