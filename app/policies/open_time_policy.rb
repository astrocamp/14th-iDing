# frozen_string_literal: true

class OpenTimePolicy < ApplicationPolicy
  def edit?
    @user.restaurants.present?
  end

  def update?
    edit?
  end
end
