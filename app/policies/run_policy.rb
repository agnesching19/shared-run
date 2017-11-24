class RunPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where.not(latitude: nil, longitude: nil).order(created_at: :desc)
    end
  end

  def create?
    return true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
