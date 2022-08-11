class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.role == "tutor"
        users = scope.where(role: "student").select do |student|
          result = false
          courses = Course.where(student: student, status: 1)
          courses.each do |course|
            result = true if course.tutor == user
            result = true if manager?(user, course.tutor)
          end
          result
        end
        return User.where(id: users.map(&:id)).order(:first_name, :last_name)
      else
        return scope.where(role: "tutor").order(:first_name, :last_name)
      end
    end
  end

  def show?
    if (record == user) || (record.role == "tutor" && record.visible)
      return true
    elsif record.role == "student" && record.visible
      courses = Course.where(student: record)
      courses.each do |course|
        return true if course.tutor == user
        return true if manager?(user, course.tutor)
      end
    end

    false
  end
end
