# frozen_string_literal: true

class HolidayPolicy < ApplicationPolicy
  def create?
    @user.restaurants.present?
  end

  def destroy?
    create?
  end
end
