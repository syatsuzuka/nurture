class AssignmentTemplatesSetPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all.order(:category, :name) if user.role == "tutor"
    end
  end

  def index?
    user.role == "tutor"
  end

  def create?
    user.role == "tutor"
  end

  def new?
    create?
  end

  def update?
    record.user == user
  end

  def edit?
    update?
  end

  def destroy?
    record.user == user
  end

  def import?
    record.user == user
  end

  def upload?
    import?
  end

  def export?
    user.role == "tutor"
  end
end
