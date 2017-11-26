class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    return true
  end

  def create?
    return true
  end

  def show?
    return true
  end

  def destroy?
    record.user == user
  end
end
