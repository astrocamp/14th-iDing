# frozen_string_literal: true

class HolidayPolicy < ApplicationPolicy
  def destroy?
    @user.restaurants.present?
  end
end
