# frozen_string_literal: true

class OpenTimePolicy < ApplicationPolicy
  def edit?
    @user.restaurants.present?
  end

  def update?
    edit?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
