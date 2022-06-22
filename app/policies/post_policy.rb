class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      true
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def edit?
    true
  end

  def update?
    true
  end

  def index?
    true
  end

  def destroy?
    true
  end
end
