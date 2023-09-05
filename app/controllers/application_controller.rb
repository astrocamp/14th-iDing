# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized # 還要切個畫面

  private

  def not_found
    render file: Rails.root.join('public', '404.html'),
           status: 404,
           layout: false
  end
end
