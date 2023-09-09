# frozen_string_literal: true

class TablePolicy < ApplicationPolicy
  def show?
    @user.restaurants.present?
  end
end
