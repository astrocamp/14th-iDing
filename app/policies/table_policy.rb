# frozen_string_literal: true

class TablePolicy < ApplicationPolicy
  def index?
    @user.restaurants.present?
  end

  def show?
    index?
  end

  def new?
    index?
  end

  def create?
    index?
  end

  def edit?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
