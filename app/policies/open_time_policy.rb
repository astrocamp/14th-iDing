class OpenTimePolicy < ApplicationPolicy
  
  def index?
    true
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
    create?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
