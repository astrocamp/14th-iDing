class ReservationPolicy < ApplicationPolicy
  def search?
    @user.restaurants.present? || super_admin?
  end

  def create?
    @user.restaurants.present?
  end

  def edit?
    create?
  end

  def update?
    create?
  end

  def destroy?
    create? || super_admin?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
