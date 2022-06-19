class PostPolicy < ApplicationPolicy

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
     def resolve
       true

     end
  end

  def index?
    true
  end
end
