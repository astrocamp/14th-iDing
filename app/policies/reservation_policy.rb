class ReservationPolicy < ApplicationPolicy
  def search?
    owner? || super_admin?
  end

  def create?
    owner?
  end

  def edit?
    create?
  end

  def update?
    create?
  end

  def destroy?
    owner? || super_admin?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
