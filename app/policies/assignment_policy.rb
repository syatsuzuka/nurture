class AssignmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    true
  end

  def edit?
    update?
  end

  def destroy?
    true
  end

  def all?
    true
  end

  def dashboard?
    true
  end

  def review?
    true
  end

  def close?
    true
  end

  def close2?
    true
  end

  def done?
    true
  end

  def export?
    true
  end
end
