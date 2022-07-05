class AssignmentTemplatePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def create?
    user.role == "tutor"
  end

  def new?
    create?
  end

  def update?
    record.assignment_templates_set.user == user
  end

  def edit?
    update?
  end

  def destroy?
    record.assignment_templates_set.user == user
  end
end
