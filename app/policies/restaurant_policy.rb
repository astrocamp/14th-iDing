# frozen_string_literal: true

class RestaurantPolicy < ApplicationPolicy
  def edit?
    user_has_restaurant?
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
end
