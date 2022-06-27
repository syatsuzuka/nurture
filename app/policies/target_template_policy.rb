class TargetTemplatePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.select { |target_template| target_template.target_templates_set.user == user }
    end
  end

  def create?
    user.role == "tutor"
  end

  def new?
    create?
  end

  def update?
    record.target_templates_set.user == user
  end

  def edit?
    update?
  end

  def destroy?
    record.target_templates_set.user == user
  end

  def import?
    user.role == "tutor"
  end

  def upload?
    import?
  end
end
