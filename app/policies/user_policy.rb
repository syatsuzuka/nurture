class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.role == "tutor"
        scope.where(role: "student", visible: true)
      else
        scope.where(role: "tutor", visible: true)
      end
    end
  end

  def show?
    true
  end
end
