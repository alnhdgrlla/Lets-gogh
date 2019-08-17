class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    record.user == user || record.supply.user == user
  end

  def create?
    true
  end

  def update?
    record.supply.user == user
  end
end
