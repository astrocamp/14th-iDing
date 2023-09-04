class RestaurantPolicy < ApplicationPolicy
  
  def new?
    user_has_restaurant?
  end

  def create?
    new?
  end

  def edit?
    new? 
  end

  def update?
    new?
  end

  def destroy?
    @user.role == 'super_admin'
  end
  
  private


  def user_has_restaurant?
    @user.restaurants.present?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
